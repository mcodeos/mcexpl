export type SectionKey = 'tutorial' | 'recipes' | 'reference'

export interface CatalogExample {
  id: string
  title: string
  summary: string
  route: string
  readme: string
  anchor: string
  files: string[]
}

export interface CatalogChapter {
  id: string
  title: string
  description: string
  examples: CatalogExample[]
}

export interface CatalogSection {
  key: SectionKey
  title: string
  description: string
  link: string
  collapsed: boolean
  chapters: CatalogChapter[]
}

type ExampleInput = [
  id: string,
  slug: string,
  title: string,
  summary: string,
  files?: string[],
]

function headingAnchor(heading: string): string {
  const slug = heading
    .normalize('NFKD')
    .toLowerCase()
    .trim()
    .replace(/[`'’]/g, '')
    .replace(/[^\p{Letter}\p{Number}\s-]/gu, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
  return /^\d/.test(slug) ? `_${slug}` : slug
}

function makeChapter(
  section: SectionKey,
  id: string,
  directory: string,
  title: string,
  description: string,
  examples: ExampleInput[],
): CatalogChapter {
  return {
    id,
    title,
    description,
    examples: examples.map(([exampleId, slug, exampleTitle, summary, files]) => ({
      id: exampleId,
      title: exampleTitle,
      summary,
      route: `/${section}/${id}/${slug}`,
      readme: `${directory}/README.md`,
      anchor: headingAnchor(exampleTitle),
      files: files ?? [`${directory}/${slug}.mc`],
    })),
  }
}

const tutorialChapters: CatalogChapter[] = [
  makeChapter('tutorial', '00', '00-getting-started', '00 Getting Started', 'The smallest useful MCode files and connection syntax.', [
    ['001', '001-power-net', '001 Power Net', 'Declare a source and name its power rails.'],
    ['002', '002-resistor-led', '002 Resistor LED', 'Build a current-limited LED path.'],
    ['003', '003-decoupling-capacitor', '003 Decoupling Capacitor', 'Place a capacitor across a supply rail.'],
    ['004', '004-button-pullup', '004 Button Pull-Up', 'Create a normally-high button input.'],
  ]),
  makeChapter('tutorial', '01', '01-basic-circuits', '01 Basic Circuits', 'Common analog building blocks and polarity-aware connections.', [
    ['011', '011-voltage-divider', '011 Voltage Divider', 'Create a measured resistor-divider output.'],
    ['012', '012-rc-low-pass-filter', '012 RC Low-Pass Filter', 'Combine resistance and capacitance as a filter.'],
    ['013', '013-diode-rectifier', '013 Diode Rectifier', 'Use explicit diode polarity in a rectifier path.'],
  ]),
  makeChapter('tutorial', '02', '02-circuits-with-branches', '02 Circuits With Branches', 'Named nodes shared by protection and power branches.', [
    ['021', '021-zener-clamp', '021 Zener Clamp Branch', 'Add a Zener clamp to a protected node.'],
    ['022', '022-tvs-input-protection', '022 TVS Input Protection Branch', 'Protect an input with a TVS branch.'],
    ['023', '023-input-rc-esd', '023 Input RC ESD', 'Combine series resistance, filtering, and ESD protection.'],
    ['024', '024-simple-power-branch', '024 Simple Power Branch', 'Feed multiple loads from one named rail.'],
  ]),
  makeChapter('tutorial', '03', '03-define-components-and-interfaces', '03 Define Components And Interfaces', 'Local component types, pins, ranges, and interface roles.', [
    ['031', '031-named-pins-component', '031 Named Pins Component', 'Define and instantiate a component with named pins.'],
    ['032', '032-pin-directions-and-ranges', '032 Pin Directions And Ranges', 'Describe pin directions, ranges, and indexed names.'],
    ['033', '033-uart-interface-binding', '033 UART Interface Binding', 'Bind physical pins to a UART role.'],
    ['034', '034-i2c-sensor-component', '034 I2C Sensor Component', 'Define controller and sensor I2C interfaces.'],
    ['035', '035-spi-flash-component', '035 SPI Flash Component', 'Define SPI master and flash components.'],
  ]),
  makeChapter('tutorial', '04', '04-functions-and-reuse', '04 Functions And Reuse', 'Reusable component methods, returns, and inline construction.', [
    ['041', '041-led-indicator-function', '041 LED Indicator Function', 'Give an LED a reusable connection method.'],
    ['042', '042-pullup-helper-function', '042 Pull-Up Helper Function', 'Return an instance and chain helper calls.'],
    ['043', '043-inline-construction-function', '043 Inline Construction Function', 'Name a helper instance inside a method call.'],
    ['044', '044-decoupling-library-method', '044 Decoupling Library Method', 'Reuse a library method on two rails.'],
  ]),
  makeChapter('tutorial', '05', '05-dynamic-pins-and-conditions', '05 Dynamic Pins And Conditions', 'Constructor-driven attributes and variant-specific pins.', [
    ['051', '051-led-package-variant', '051 LED Package Variant', 'Select package metadata with conditions.'],
    ['052', '052-gpio-expander-pins', '052 GPIO Expander Pins', 'Append pins for a larger component variant.'],
    ['053', '053-rs485-termination-pins', '053 RS485 Termination Pins', 'Add optional connection pins and termination.'],
  ]),
  makeChapter('tutorial', '06', '06-multi-file-project', '06 Modules And A Multi-File Project', 'Reusable module ports followed by local cross-file imports.', [
    ['061', '061-reusable-module', '061 Reusable Module', 'Define a reusable LED circuit module.'],
    ['062', '062-main', '062 Multi-File Sensor Node', 'Compose power, MCU, and sensor definitions from local files.', [
      '06-multi-file-project/062-main.mc',
      '06-multi-file-project/power.mc',
      '06-multi-file-project/mcu.mc',
      '06-multi-file-project/sensor.mc',
    ]],
  ]),
]

const recipeChapters: CatalogChapter[] = [
  makeChapter('recipes', '20', '20-power-recipes', '20 Power Recipes', 'Power sources, regulators, converters, and power trees.', [
    ['201', '201-battery-input', '201 Battery Input', 'Represent a battery-powered input.'],
    ['202', '202-usb-5v-input', '202 USB 5 V Input', 'Use USB as a 5 V source.'],
    ['203', '203-ldo-5v-to-3v3', '203 LDO 5 V to 3.3 V', 'Convert 5 V to 3.3 V with an LDO.'],
    ['204', '204-buck-12v-to-5v', '204 Buck Module 12 V to 5 V', 'Use a complete three-terminal buck module.'],
    ['205', '205-power-tree-5v-3v3-1v8', '205 Power Tree 5 V, 3.3 V, 1.8 V', 'Build a small multi-rail power tree.'],
    ['206', '206-buck-controller-power-stage', '206 Buck Controller Power Stage', 'Build an external asynchronous buck power stage.'],
  ]),
  makeChapter('recipes', '21', '21-digital-io-recipes', '21 Digital IO Recipes', 'GPIO inputs, indicators, transistor loads, and PWM outputs.', [
    ['211', '211-gpio-led', '211 GPIO LED', 'Drive an LED from a GPIO signal.'],
    ['212', '212-button-input', '212 Button Input', 'Connect a button to a digital input.'],
    ['213', '213-nmos-low-side-driver', '213 NMOS Low-Side Driver', 'Switch a load with an NMOS.'],
    ['214', '214-relay-driver-with-flyback-diode', '214 Relay Driver With Flyback Diode', 'Drive a relay with inductive-load protection.'],
    ['215', '215-rgb-led-pwm', '215 RGB LED PWM', 'Connect RGB channels to PWM-style controls.'],
  ]),
  makeChapter('recipes', '22', '22-interface-recipes', '22 Interface Recipes', 'Board-level UART, I2C, SPI, USB, and RS485 connections.', [
    ['221', '221-uart-debug-header', '221 UART Debug Header', 'Expose UART signals on a debug header.'],
    ['222', '222-i2c-sensor-bus', '222 I2C Sensor Bus', 'Connect a controller and sensor bus.'],
    ['223', '223-spi-flash', '223 SPI Flash', 'Connect an SPI controller to flash.'],
    ['224', '224-usb-device-port', '224 USB Device Port', 'Model a USB device connector.'],
    ['225', '225-rs485-uart-bridge', '225 RS485 UART Bridge', 'Bridge UART signals to an RS485 transceiver.'],
  ]),
  makeChapter('recipes', '23', '23-sensor-recipes', '23 Sensor Recipes', 'Compact analog sensor front ends and ADC filtering.', [
    ['231', '231-ntc-temperature-divider', '231 NTC Temperature Divider', 'Use an NTC thermistor in a divider.'],
    ['232', '232-photodiode-input', '232 Photodiode Input', 'Connect a buffered photodiode input stage.'],
    ['233', '233-adc-input-rc-filter', '233 ADC Input RC Filter', 'Filter an analog signal before an ADC.'],
  ]),
  makeChapter('recipes', '24', '24-board-level-recipes', '24 Board-Level Recipes', 'Complete board-level compositions built from smaller patterns.', [
    ['241', '241-minimal-mcu-board', '241 Minimal MCU Board', 'Start a minimal powered MCU design.'],
    ['242', '242-usb-powered-mcu-board', '242 USB-Powered MCU Board', 'Combine USB input, regulation, and MCU power.'],
    ['243', '243-i2c-sensor-node', '243 I2C Sensor Node', 'Compose power, MCU, I2C, and sensor blocks.'],
    ['244', '244-mono-audio-line-output', '244 Mono Audio Line Output', 'Buffer and AC-couple a line-level output.'],
  ]),
]

const referenceChapters: CatalogChapter[] = [
  makeChapter('reference', '90', '90-language-reference', '90 Language Reference', 'Focused, runnable examples for looking up MCode syntax.', [
    ['901', '901-component-definition', '901 Component Definition', 'Define a custom component and named pins.'],
    ['902', '902-attributes-spec-typed-parameters', '902 Attributes, Spec, And Typed Parameters', 'Use typed parameters and specification attributes.'],
    ['903', '903-pins-ranges-indexed-names', '903 Pins, Ranges, And Indexed Names', 'Declare directions, ranges, and indexed signals.'],
    ['904', '904-module-ports', '904 Module Ports', 'Declare and connect reusable module ports.'],
    ['905', '905-interface-binding-roles', '905 Interface Binding And Roles', 'Bind physical pins to an interface role.'],
    ['906', '906-functions-method-calls', '906 Functions And Method Calls', 'Use functions, this, returns, and method chains.'],
    ['907', '907-conditions-and-dynamic-pins', '907 Conditions And Dynamic Pins', 'Select attributes and append variant pins.'],
    ['908', '908-inline-construction-library-method', '908 Inline Construction And Library Methods', 'Construct a named helper inline and call a library method.'],
    ['909', '909-cross-file-use', '909 Cross-File Use', 'Load a reusable LED block from a local file.', [
      '90-language-reference/909-cross-file-use/main.mc',
      '90-language-reference/909-cross-file-use/led_block.mc',
    ]],
  ]),
]

export const catalog: CatalogSection[] = [
  {
    key: 'tutorial',
    title: 'Tutorial',
    description: 'Learn MCode in a fixed sequence from first nets to a multi-file project.',
    link: '/tutorial/',
    collapsed: false,
    chapters: tutorialChapters,
  },
  {
    key: 'recipes',
    title: 'Recipes',
    description: 'Find practical circuit patterns grouped by application domain.',
    link: '/recipes/',
    collapsed: true,
    chapters: recipeChapters,
  },
  {
    key: 'reference',
    title: 'Language Reference',
    description: 'Look up focused syntax forms in small runnable examples.',
    link: '/reference/',
    collapsed: true,
    chapters: referenceChapters,
  },
]

export const allExamples = catalog.flatMap((section) =>
  section.chapters.flatMap((chapter) => chapter.examples),
)

export function makeSidebar() {
  return catalog.map((section) => ({
    text: section.title,
    link: section.link,
    collapsed: section.collapsed,
    items: section.chapters.map((chapter) => ({
      text: chapter.title,
      collapsed: section.key !== 'tutorial',
      items: chapter.examples.map((example) => ({
        text: example.title,
        link: example.route,
      })),
    })),
  }))
}

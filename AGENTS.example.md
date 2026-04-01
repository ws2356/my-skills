# Instructions
## General guidelines
- **Always** check for existing code that has similar requirements or functionality. Match the design of existing code.
- **Always** conform to modular design principles. Independent logic should be implemented in separate classes and projects as appropriate. If you are not sure about the design, stop and ask.

## Technology Stack

## Directory Structure

## Building

## Planning
- **Always** make a plan document in markdown for complex tasks.
  - Complex tasks include refactoring existing code and adding features.
  - You can skip the plan for simple tasks like bugfixes, test authoring, or answering questions.
  - Begin by doing research on the existing code and documentation.
  - Your human operator will review the plan document and give feedback.

## Documentation
- Maintain documentation in `docs/`.
- **Always** update the documentation if you are changing the design of existing components that have documentation.

## Formatting
- **Always** auto code formating should be done in a separate commit from the code changes. This makes it easier to review the code changes without being distracted by formatting changes.

## Testing
- **Always** write meaningful unit tests for new code and for any existing code that you are modifying.
- **Always** before a large code change, ensure that there are sufficient tests in place to verify the behavior of the code before and after the refactor.

## Git
- **Always** check in small, self-contained commits. Each commit should have a single purpose.
- **Always** write descriptive commit messages.

## Code reviewing
- **Always** review your code before committing. Look for any potential bugs or regressions, code smells.
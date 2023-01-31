#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CAMediaTimingFunction+MDCAnimationTiming.h"
#import "MaterialAnimationTiming.h"
#import "UIView+MDCTimingFunction.h"
#import "MaterialAvailability.h"
#import "MDCAvailability.h"
#import "MaterialTextControls+BaseTextAreas.h"
#import "MDCBaseTextArea.h"
#import "MDCBaseTextAreaDelegate.h"
#import "MaterialTextControls+BaseTextFields.h"
#import "MDCBaseTextField.h"
#import "MDCBaseTextFieldDelegate.h"
#import "MaterialTextControls+Enums.h"
#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlState.h"
#import "MaterialTextControls+FilledTextAreas.h"
#import "MDCFilledTextArea.h"
#import "MaterialTextControls+FilledTextFields.h"
#import "MDCFilledTextField.h"
#import "MaterialTextControls+OutlinedTextAreas.h"
#import "MDCOutlinedTextArea.h"
#import "MaterialTextControls+OutlinedTextFields.h"
#import "MDCOutlinedTextField.h"
#import "MaterialMath.h"
#import "MDCMath.h"
#import "MaterialTextControlsPrivate+BaseStyle.h"
#import "MDCTextControlStyleBase.h"
#import "MDCTextControlVerticalPositioningReferenceBase.h"
#import "MaterialTextControlsPrivate+FilledStyle.h"
#import "MDCTextControlStyleFilled.h"
#import "MDCTextControlVerticalPositioningReferenceFilled.h"
#import "MaterialTextControlsPrivate+OutlinedStyle.h"
#import "MDCTextControlStyleOutlined.h"
#import "MDCTextControlVerticalPositioningReferenceOutlined.h"
#import "MaterialTextControlsPrivate+Shared.h"
#import "MDCTextControl.h"
#import "MDCTextControlAssistiveLabelDrawPriority.h"
#import "MDCTextControlAssistiveLabelView.h"
#import "MDCTextControlAssistiveLabelViewLayout.h"
#import "MDCTextControlColorViewModel.h"
#import "MDCTextControlGradientManager.h"
#import "MDCTextControlHorizontalPositioning.h"
#import "MDCTextControlHorizontalPositioningReference.h"
#import "MDCTextControlLabelAnimation.h"
#import "MDCTextControlLabelSupport.h"
#import "MDCTextControlPlaceholderSupport.h"
#import "MDCTextControlSideViewSupport.h"
#import "MDCTextControlVerticalPositioningReference.h"
#import "UIBezierPath+MDCTextControlStyle.h"
#import "MaterialTextControlsPrivate+TextFields.h"
#import "MDCBaseTextFieldLayout.h"
#import "MDCTextControlTextField.h"
#import "MDCTextControlTextFieldSideViewAlignment.h"
#import "MaterialTextControlsPrivate+UnderlinedStyle.h"
#import "MDCTextControlStyleUnderlined.h"
#import "MDCTextControlVerticalPositioningReferenceUnderlined.h"

FOUNDATION_EXPORT double MaterialComponentsVersionNumber;
FOUNDATION_EXPORT const unsigned char MaterialComponentsVersionString[];


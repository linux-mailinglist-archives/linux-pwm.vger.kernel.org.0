Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56BEE0269
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfJVLBA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 07:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfJVLA7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Oct 2019 07:00:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDEEE21783;
        Tue, 22 Oct 2019 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571742058;
        bh=3wr2brRuPL3nrxk9/+udPN9G8ogjlg23jMUoDvyxk+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OW/zqk0hi6SfASYvNIGLiANYFDtusXa3A6NDHzMdckQrZ6Rt9DE+cRw3etOvdjo+P
         3S/ja/s9cnWBUY8g6s8EpDcUAB/wayph/AlomQ0h5Y3ifGmB5SzIGJAsKGq1k5iwub
         yMFpAfhZnR02eyIBHVyBiqu7HIp3nhV9yo4jcduU=
Date:   Tue, 22 Oct 2019 12:00:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 1/8] dt-bindings: mfd: iqs62x: Add bindings
Message-ID: <20191022120051.686ed9f9@archlinux>
In-Reply-To: <1571631083-4962-2-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
        <1571631083-4962-2-git-send-email-jeff@labundy.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 20 Oct 2019 23:11:16 -0500
Jeff LaBundy <jeff@labundy.com> wrote:

> This patch adds binding documentation for six-channel members of the
> Azoteq ProxFusion family of sensor devices.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

I'm not sure if Lee has made the switch for mfd entirely yet, but
mostly new dt bindings need to be in yaml format as it allows
automated parsing of the examples + bindings using them for
correctness.

One comment inline.  I'm far from an expert on most of the stuff here
so will leave it for others!

Jonathan


> ---
>  Documentation/devicetree/bindings/mfd/iqs62x.txt | 242 +++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.txt b/Documentation/devicetree/bindings/mfd/iqs62x.txt
> new file mode 100644
> index 0000000..089f567
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/iqs62x.txt
> @@ -0,0 +1,242 @@
> +Azoteq IQS620A/621/622/624/625 ProxFusion Sensor Family
> +
> +Required properties:
> +
> +- compatible			: Must be equal to one of the following:
> +				  "azoteq,iqs620a"
> +				  "azoteq,iqs621"
> +				  "azoteq,iqs622"
> +				  "azoteq,iqs624"
> +				  "azoteq,iqs625"
> +
> +- reg				: I2C slave address for the device.
> +
> +- interrupts			: GPIO to which the device's active-low RDY
> +				  output is connected (see [0]).
> +
> +Optional properties:
> +
> +- linux,fw-file			: Specifies the name of the calibration and
> +				  configuration file selected by the driver.
> +				  If this property is omitted, the filename
> +				  is selected based on the device name with
> +				  ".bin" as the extension (e.g. iqs620a.bin
> +				  for IQS620A).
> +
> +All devices accommodate a child node (e.g. "keys") that represents touch key
> +support. Required properties for the "keys" child node include:
> +
> +- compatible			: Must be equal to one of the following:
> +				  "azoteq,iqs620a-keys"
> +				  "azoteq,iqs621-keys"
> +				  "azoteq,iqs622-keys"
> +				  "azoteq,iqs624-keys"
> +				  "azoteq,iqs625-keys"
> +
> +- linux,keycodes		: Specifies an array of up to 16 numeric key-
> +				  codes corresponding to each available touch
> +				  or proximity event. An 'x' in the following
> +				  table indicates an event is supported for a
> +				  given device; specify 0 for unused events.
> +
> +  ----------------------------------------------------------------------------
> +  | #  | Event                 | IQS620A | IQS621 | IQS622 | IQS624 | IQS625 |
> +  ----------------------------------------------------------------------------
> +  | 0  | CH0 Touch             |    x    |    x   |    x   |    x   |    x   |
> +  |    | Antenna 1 Touch*      |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 1  | CH0 Proximity         |    x    |    x   |    x   |    x   |    x   |
> +  |    | Antenna 1 Proximity*  |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 2  | CH1 Touch             |    x    |    x   |    x   |    x   |    x   |
> +  |    | Antenna 1 Deep Touch* |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 3  | CH1 Proximity         |    x    |    x   |    x   |    x   |    x   |
> +  ----------------------------------------------------------------------------
> +  | 4  | CH2 Touch             |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 5  | CH2 Proximity         |    x    |        |        |        |        |
> +  |    | Antenna 2 Proximity*  |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 6  | Metal (+) Touch**     |    x    |    x   |        |        |        |
> +  |    | Antenna 2 Deep Touch* |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 7  | Metal (+) Proximity** |    x    |    x   |        |        |        |
> +  |    | Antenna 2 Touch*      |    x    |        |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 8  | Metal (-) Touch**     |    x    |    x   |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 9  | Metal (-) Proximity** |    x    |    x   |        |        |        |
> +  ----------------------------------------------------------------------------
> +  | 10 | SAR Active***         |    x    |        |    x   |        |        |
> +  ----------------------------------------------------------------------------
> +  | 11 | SAR Quick Release***  |    x    |        |    x   |        |        |
> +  ----------------------------------------------------------------------------
> +  | 12 | SAR Movement***       |    x    |        |    x   |        |        |
> +  ----------------------------------------------------------------------------
> +  | 13 | SAR Filter Halt***    |    x    |        |    x   |        |        |
> +  ----------------------------------------------------------------------------
> +  | 14 | Wheel Up              |         |        |        |    x   |        |
> +  ----------------------------------------------------------------------------
> +  | 15 | Wheel Down            |         |        |        |    x   |        |
> +  ----------------------------------------------------------------------------
> +  *   Dual-channel SAR. Replaces CH0-2 and metal touch and proximity events if
> +      enabled via firmware.
> +  **  "+" and "-" refer to the polarity of the channel's delta (LTA - counts),
> +      where "LTA" is defined as the channel's long-term average.
> +  *** Single-channel SAR. Replaces CH0-2 touch and proximity events if enabled
> +      via firmware.
> +
> +The "keys" child node supports "hall_switch_north" and "hall_switch_south"
> +child nodes that represent north-field and south-field Hall-effect sensor
> +events, respectively (IQS620A/621/622 only). Required properties include:
> +
> +- linux,code			: Numeric switch code.
> +
> +Optional properties for the "hall_switch_north" and "hall_switch_south" nodes:
> +
> +- azoteq,use-prox		: Boolean to specify that Hall-effect sensor
> +				  reporting must use the device's wide-range
> +				  proximity threshold instead of its narrow-
> +				  range touch threshold.
> +
> +Note: North/south-field orientation is reversed on the IQS620AXzCSR device due
> +      to its flip-chip package.
> +
> +The IQS620A supports a PWM controller node; required properties include:
> +
> +- compatible			: Must be equal to "azoteq,iqs620a-pwm".
> +
> +- #pwm-cells			: Must be equal to 2 (see [1]).
> +
> +The IQS622 supports an additional child node (e.g. "prox") that represents
> +active IR detection; required properties include:
> +
> +- compatible			: Must be equal to "azoteq,iqs622-prox".
> +
> +Optional properties for the "prox" child node:
> +
> +- azoteq,use-prox		: Boolean to specify that IR threshold event
> +				  reporting must use the device's wide-range
> +				  proximity threshold instead of its narrow-
> +				  range touch threshold.
This one is certainly interesting.  Does it always make sense to
set this only at boot?  Of could we control this from userspace?

It sits somewhere between a hardware requirement that we should
put in DT and a policy decision.  I can conceive of devices where both
options make sense, but also ones where only one does.

> +
> +[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +[1]: Documentation/devicetree/bindings/pwm/pwm.txt
> +
> +Example 1: Dual capacitive buttons with additional "air button," unipolar lid
> +	   switch and panel-mounted LED.
> +
> +	&i2c1 {
> +		/* ... */
> +
> +		iqs620a: iqs620a@44 {
> +			compatible = "azoteq,iqs620a";
> +			reg = <0x44>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +			iqs620a_keys: keys {
> +				compatible = "azoteq,iqs620a-keys";
> +
> +				linux,keycodes = <KEY_SELECT>,
> +						 <KEY_MENU>,
> +						 <KEY_OK>,
> +						 <KEY_MENU>;
> +
> +				hall_switch_south {
> +					linux,code = <SW_LID>;
> +					azoteq,use-prox;
> +				};
> +			};
> +
> +			iqs620a_pwm: pwm {
> +				compatible = "azoteq,iqs620a-pwm";
> +				#pwm-cells = <2>;
> +			};
> +		};
> +
> +		/* ... */
> +	};
> +
> +	pwmleds {
> +		compatible = "pwm-leds";
> +
> +		panel {
> +			pwms = <&iqs620a_pwm 0 1000000>;
> +			max-brightness = <255>;
> +		};
> +	};
> +
> +Example 2: Single inductive button with bipolar dock/tablet-mode switch.
> +
> +	&i2c1 {
> +		/* ... */
> +
> +		iqs620a: iqs620a@44 {
> +			compatible = "azoteq,iqs620a";
> +			reg = <0x44>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +			linux,fw-file = "iqs620a_coil.bin";
> +
> +			iqs620a_keys: keys {
> +				compatible = "azoteq,iqs620a-keys";
> +
> +				linux,keycodes = <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <KEY_MUTE>;
> +
> +				hall_switch_north {
> +					linux,code = <SW_DOCK>;
> +				};
> +
> +				hall_switch_south {
> +					linux,code = <SW_TABLET_MODE>;
> +				};
> +			};
> +		};
> +
> +		/* ... */
> +	};
> +
> +Example 3: Dual capacitive buttons with volume knob.
> +
> +	&i2c1 {
> +		/* ... */
> +
> +		iqs624: iqs624@44 {
> +			compatible = "azoteq,iqs624";
> +			reg = <0x44>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +			iqs624_keys: keys {
> +				compatible = "azoteq,iqs624-keys";
> +
> +				linux,keycodes = <BTN_0>,
> +						 <0>,
> +						 <BTN_1>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <0>,
> +						 <KEY_VOLUMEUP>,
> +						 <KEY_VOLUMEDOWN>;
> +			};
> +		};
> +
> +		/* ... */
> +	};


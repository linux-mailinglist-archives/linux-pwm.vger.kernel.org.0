Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98834B0992
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Feb 2022 10:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiBJJdY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Feb 2022 04:33:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiBJJdV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Feb 2022 04:33:21 -0500
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE16C64;
        Thu, 10 Feb 2022 01:33:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 579222985;
        Thu, 10 Feb 2022 10:33:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jpe8GPq-IVlo; Thu, 10 Feb 2022 10:33:20 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id DD8193562; Thu, 10 Feb 2022 10:33:19 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Date:   Thu, 10 Feb 2022 10:33:06 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Sven Schwermer <sven@svenschwermer.de>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de, andy.shevchenko@gmail.com,
        robh@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <YgTb0sRSaO1EPsOW@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Sven Schwermer <sven@svenschwermer.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de, andy.shevchenko@gmail.com,
        robh@kernel.org
References: <20220208191236.660172-1-sven@svenschwermer.de>
 <20220208191236.660172-2-sven@svenschwermer.de>
 <YgOGksA8kruvFLY2@ada-deb-carambola.ifak-system.com>
 <2bf7a4c4-1661-d800-51d3-6e6287b5c6fc@svenschwermer.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf7a4c4-1661-d800-51d3-6e6287b5c6fc@svenschwermer.de>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hei hei,

Am Thu, Feb 10, 2022 at 08:55:07AM +0100 schrieb Sven Schwermer:
> Hi Alex,
> 
> On 2/9/22 10:17, Alexander Dahl wrote:
> > > +    rgb-led {
> > 
> > I think this should be 'led-controller'. See
> > Documentation/devicetree/bindings/leds/common.yaml for reference.
> 
> Sure, I don't have a preference.
> 
> > > +        multi-led {
> > > +          color = <LED_COLOR_ID_RGB>;
> > > +          function = LED_FUNCTION_INDICATOR;
> > > +          max-brightness = <65535>;
> > > +
> > > +          led-red {
> > > +              pwms = <&pwm1 0 1000000>;
> > > +              color = <LED_COLOR_ID_RED>;
> > > +          };
> > > +
> > > +          led-green {
> > > +              pwms = <&pwm2 0 1000000>;
> > > +              color = <LED_COLOR_ID_GREEN>;
> > > +          };
> > > +
> > > +          led-blue {
> > > +              pwms = <&pwm3 0 1000000>;
> > > +              color = <LED_COLOR_ID_BLUE>;
> > > +          };
> > 
> > Not sure if those node names should be more generic like led-0, led-1
> > etc.?  At least the color information is redundant here.  This would
> > make it more similar to bindings of other LED drivers.
> 
> I don't see how naming them led-{0,1,2} would be better in any way, please
> elaborate.

- consistency with other LED driver bindings
- spot the number of "sub"-LEDs more easily
- prevent all kinds of different names people will come up with, if
  all is allowed instead of a clear scheme

The color is in the color property anyways.

> > And how is it supposed to be named if you have multiple
> > "multi-led"s, e.g. one on three PWM channels, and another one on three
> > different PWM channels?
> 
> I'm not 100% sure what you mean. If you want multiple instances of these
> multi-color PWM LEDs, you'd do something like this:
> 
> indicator-led-controller {
>     compatible = "pwm-leds-multicolor";
>     multi-led {
>       color = <LED_COLOR_ID_RGB>;
>       function = LED_FUNCTION_INDICATOR;
>       max-brightness = <65535>;
>       led-red {
>           pwms = <&pwm1 0 1000000>;
>           color = <LED_COLOR_ID_RED>;
>       };
>       led-green {
>           pwms = <&pwm2 0 1000000>;
>           color = <LED_COLOR_ID_GREEN>;
>       };
>       led-blue {
>           pwms = <&pwm3 0 1000000>;
>           color = <LED_COLOR_ID_BLUE>;
>       };
>     };
> };
> status-led-controller {
>     compatible = "pwm-leds-multicolor";
>     multi-led {
>       color = <LED_COLOR_ID_MULTI>;
>       function = LED_FUNCTION_STATUS;
>       max-brightness = <255>;
>       led-red {
>           pwms = <&pwm4 0 1000000>;
>           color = <LED_COLOR_ID_RED>;
>       };
>       led-amber {
>           pwms = <&pwm5 0 1000000>;
>           color = <LED_COLOR_ID_AMBER>;
>       };
>     };
> };

I would have expected something like this:

  led-controller-0 {
      compatible = "pwm-leds-multicolor";

      multi-led-0 {
        color = <LED_COLOR_ID_RGB>;
        function = LED_FUNCTION_INDICATOR;
        max-brightness = <65535>;

        led-0 {
            pwms = <&pwm1 0 1000000>;
            color = <LED_COLOR_ID_RED>;
        };

        led-1 {
            pwms = <&pwm2 0 1000000>;
            color = <LED_COLOR_ID_GREEN>;
        };

        led-2 {
            pwms = <&pwm3 0 1000000>;
            color = <LED_COLOR_ID_BLUE>;
        };
      };

      multi-led-1 {
        color = <LED_COLOR_ID_RGB>;
        function = LED_FUNCTION_INDICATOR;
        max-brightness = <65535>;

        led-0 {
            pwms = <&pwm1 0 1000000>;
            color = <LED_COLOR_ID_RED>;
        };

        led-1 {
            pwms = <&pwm2 0 1000000>;
            color = <LED_COLOR_ID_GREEN>;
        };

        led-2 {
            pwms = <&pwm3 0 1000000>;
            color = <LED_COLOR_ID_BLUE>;
        };
      };
  };

Greets
Alex


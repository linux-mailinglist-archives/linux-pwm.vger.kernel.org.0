Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307CD49C74C
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiAZKRs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 05:17:48 -0500
Received: from mail.schwermer.no ([49.12.228.226]:59026 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbiAZKRq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 05:17:46 -0500
Message-ID: <56b7e838-5fea-3499-b110-d426cc2efff7@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643192263;
        bh=KPzO7WnOnxMPOawnkCFiXjLymJ2szH0IifcN3jNOF/Q=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=qNRUeKa6Wv1lahRg2pDxQn70XuUNIe0u9G8FNBgTnTRI/q61lOQ8F/7Ml4/mMoHvS
         5pWwKgzOdP/UPggMA+sA/QE6GTR8ogyDOuK25G0Is/u8clXiRjaQD0Ah1zmg9AzbZY
         o4ITPSO2s78ZtM8gevlA7xap+HfgVC4+C6EtR714+Ha59PINROShIXDo2i009VyMnv
         6e1YtXBOBglTEDbgGOIErzTnJTQi2BhnrIlVoabPJDS9+MPeTrZqu2tnsTrB1AYks/
         uSqICNvWFM2Dz5U3snX9BQyBruSxaCDngzfSnUcXpmGUNsw7EFS75MPwHXQixnZ4Jt
         eroshTsE663AA==
Date:   Wed, 26 Jan 2022 11:17:41 +0100
Mime-Version: 1.0
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: leds: Add multicolor PWM LED
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
References: <20220125151226.31049-1-sven@svenschwermer.de>
 <20220125151226.31049-2-sven@svenschwermer.de>
 <20220125212736.5ffafe2b@thinkpad>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <20220125212736.5ffafe2b@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 1/25/22 21:27, Marek Behún wrote:

> what about
> 
> 	multi-led@0 {
> 		color = <LED_COLOR_ID_RGB>;
> 		function = LED_FUNCTION_INDICATOR;
> 		pwms = <&pwm1 0 1000000>,
> 		       <&pwm2 0 1000000>,
> 		       <&pwm3 0 1000000>;
> 		channels = <LED_COLOR_ID_RED>,
> 			   <LED_COLOR_ID_GREEN>,
> 			   <LED_COLOR_ID_BLUE>;
> 	};
> 
> I am not saying that it is necessarily better, just comenting that
> maybe it is, since it saves some space. `pwms` is phandle-array, so it
> can contain references to multiple pwms, and we have functions which
> make getting these pwms in driver code easy...

I have had another look at this. It seems like if you specify more than 
one PWM instance in the `pwms` property, the device tree must specify 
`pwm-names` in order for the driver to be able to request the correct 
instance (see `of_pwm_get`). In this case, the device tree would need to 
contain some strings in `pwm-names` that allow the driver to match them 
against the color IDs. Alternatively, I could re-implement the PWM 
instance request logic. Both options seem not ideal.

For the next version of this patch series, I'll go with my original 
approach. I'm open for alternatives :)

Best regards,
Sven

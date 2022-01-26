Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0D49C4D3
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 09:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiAZICO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 03:02:14 -0500
Received: from mail.schwermer.no ([49.12.228.226]:58590 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiAZICN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 03:02:13 -0500
Message-ID: <15a8a07a-adb3-423f-c188-ed2f9d03360b@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643184132;
        bh=F+YJGioc6aMLqsdUs53KWbFQBfiGqhcKLblgyms8JMo=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=EDLd2AzAsbu2Nfg8ITXyFQgdGy89QpK4gZhER+nTdIJ+qetydG+cZHNlSwA6u/xaG
         XbyJbAwU6eFqvAf2FI8SrIYEfaQqbWNUi5QdbZC74Xx5C3aTkq+6shYJUqFQTx9nO/
         Vc62suXx0ZN+N3S50gqsjb/C3B+M9DYgccIYl5MSkjwjQuRjnKqhqS4+CDe6/EOTjg
         sv0p+UeD3N8HwUR/8MtUYnujHYzmC4f5C4d3bWOivl4q+mu8WolhBRvLa6kF3Sn2f1
         TS+oLaTc8FW45dCqm+dKsTu2DjIjFphrH34f2ZkBJbDmrAPq+Sr+yHiHkHO8yH0SmC
         BsCx2XnlAYXzw==
Date:   Wed, 26 Jan 2022 09:02:11 +0100
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

Hi Marek,

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

This this nice. I misunderstood the requirements by the multicolor LED 
class so I didn't think this was possible. I will change my patch.

> Also this example won't compile with
>     make dt_bindings_check
> because you don't have pwm1, pwm2
> and pwm3 defined...

Yes, it does. The checker compiles the example DTS snippets with this in 
the header: /plugin/; // silence any missing phandle references

Best regards,
Sven

Return-Path: <linux-pwm+bounces-6254-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93757AD03C6
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2345418958EA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Jun 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F32288CB7;
	Fri,  6 Jun 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwmlL8kq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DF171C9;
	Fri,  6 Jun 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219207; cv=none; b=P31Armb7HZxP/Pm/VH3/IHczmI8lLSz3YS7zRPsp9mTlGJPmOGmd10Gzf/ljh08ogTDy3sio2Mb4CVyAPc92bUouUTI8lcBFyP2TpcA1QD4K+RnqGO7giaLWl58nho26/pmwXMadrfwIMMlLZrNxyjPNh610S83u7VkNP375BjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219207; c=relaxed/simple;
	bh=2CRemaQRzdnJp55TZWtADRVFdUvEf7uS5vdHs8BSb8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHgpFnQrqPjUZ4+t6xync97S8464Cn3JjVigIpydfRKjsDjCUlTQAOdNtW9luyZDRayUj25FG8XxcZKhmsmaWHWxhcMpJewkJNKA1YNsJqn39Wje0e+dlHjJHyfy5xacPo5tWNwCWHdMiFMssb+LhQitsVLzzP87edvqI7juoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwmlL8kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70785C4CEEB;
	Fri,  6 Jun 2025 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749219206;
	bh=2CRemaQRzdnJp55TZWtADRVFdUvEf7uS5vdHs8BSb8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwmlL8kqbyg7+7ya8q4toLANoaNbVjrKGPHd+DnIDpG5wU8C/H0wlKKqIXo0+Yxby
	 7b+T3mNkGNL5fEbvyk3OaUVUq0PIDHUCaKmDIjCRsf3l3sFonhB+elGwDDD3peTOWL
	 EuPUXqeAzEaCV5u8TAZ1WG+I5L2w1TwA/f7Le9d5zhNzE7bHhXWO2Fm28Kc/vxLRlw
	 es0xlqgsgRrz62E3HqhMMSehcLptNfF9D7Vs4FZRYd6jCUrhrtOkjQ49kStrp/UAYm
	 9N4NNWjGS5AZeU0r5XlPhNZwoqMg0A2+tbttWTsyM624Vun1lEYp2rEhIWE4BKbx7D
	 5haRNQFF3giOA==
Date: Fri, 6 Jun 2025 09:13:24 -0500
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: New default binding for PWM devices? [Was: Re: [PATCH]
 dt-bindings: timer: xlnx,xps-timer: Make PWM in example usable]
Message-ID: <20250606141324.GA1383279-robh@kernel.org>
References: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
 <a14be34c-de2a-4bea-9282-1fac7780b9a4@kernel.org>
 <crk42dsypmbyqk7avldghjq32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <crk42dsypmbyqk7avldghjq32vslmalfmmouwxzgtdci4agfhz@rkbmxj5z22fx>

On Tue, Jun 03, 2025 at 07:41:28PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, May 28, 2025 at 09:43:48AM +0200, Krzysztof Kozlowski wrote:
> > On 27/05/2025 19:15, Uwe Kleine-König wrote:
> > > With #pwm-cells = <0> no usable reference to that PWM can be created.
> > > Even though a xlnx,xps-timer device only provides a single PWM line, Linux
> > > would fail to determine the right (pwmchip, pwmnumber) combination.
> > > 
> > > Fix the example to use the recommended value 3 for #pwm-cells.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > And what about the binding itself? It allows any arbitrary value.
> > Setting it to const=3 would not break the ABI, as long as driver does
> > not care.
> 
> Oh indeed. Now I wonder about myself that I didn't notice that without a
> hint.
> 
> So with the intention to move all drivers to #pwm-cells = <3>, the patch
> to create here is:
> 
> diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> index b1597db04263..8d7a87fb2d35 100644
> --- a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> @@ -26,7 +26,8 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  '#pwm-cells': true
> +  '#pwm-cells':
> +    const: 3
>  
>    xlnx,count-width:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -82,7 +83,7 @@ examples:
>      };
>  
>      timer@800f0000 {
> -        #pwm-cells = <0>;
> +        #pwm-cells = <3>;
>          clock-names = "s_axi_aclk";
>          clocks = <&zynqmp_clk 71>;
>          compatible = "xlnx,xps-timer-1.00.a";
> 
> There is however one concern that I want to get resolved first to
> prevent churn:
> 
> In principle I think it's bad that a phandle to a PWM must contain a
> period and flags specifying the polarity. For some use cases the period
> might not matter or is implicitly given or more than one period length
> is relevant.

Why can't the period be 0 and no flags set if they aren't needed?


> So I wonder if instead of unifying all PWM bindings to #pwm-cells = <3>
> I should instead go to something like
> 
> 	mypwm: pwm {
> 		compatible = "...."
> 		#pwm-cells = <1>;
> 	};
> 
> 	fan {
> 		compatible = "pwm-fan";
> 		pwms = <&mypwm 1>;
> 		assigned-pwms = <&mypwm>;
> 		assigned-pwm-default-period-lengths-ns = <40000>;
> 		assigned-pwm-default-flags = <PWM_POLARITY_INVERTED>;
> 	};
> 
> (where the single cell specifies the index of the PWM's output).

Sigh. You just changed everyone to 3 cells and now you want to change 
again? Changing existing users to 3 was borderline churn. Changing again 
I won't be receptive to. 


> I already suggested that in
> https://lore.kernel.org/linux-pwm/jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl/.
> When I asked about that in #armlinux Rob said "no. We don't need a 2nd
> way to set period and flags." Is this still a bad idea if the
> traditional binding with 3 cells will be deprecated for all PWM
> devices? If this would be ok then, I'm also open for improvements to
> the new concept. Maybe something like:
> 
> 	fan {
> 		compatible = "pwm-fan";
> 		pwms = <&mypwm 1>;
> 		pwm-default-period-lengths-ns = <40000>;
> 		pwm-default-flags = <PWM_POLARITY_INVERTED>;
> 	};
> 
> ?

How is this any different than a slight name change?

What I also said there is that case looked like a property of the fan. 
If you want a default fan speed, then you should express that in fan 
terms (i.e. RPM or %) and then have a table to go from fan speeds to fan 
control settings (i.e. PWM duty cycle in this case). Even if you need 
something like minimum startup duty cycle, that's still a property of 
the fan.

It's the same thing for LEDs. What we ultimately care about is 
brightness, not current or PWM duty cycle. So express things where we 
can derive PWM duty cycle starting from brightness. And that's what the 
bindings do.

Rob


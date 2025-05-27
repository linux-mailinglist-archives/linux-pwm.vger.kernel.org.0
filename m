Return-Path: <linux-pwm+bounces-6153-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96473AC56D8
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DA51BA8467
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE128030B;
	Tue, 27 May 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2hNPtot"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AB280038
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366740; cv=none; b=CTRVqI9uAlIARlPVuw++1wUcINxYalaA8ezbEch024FoMQtlPmwObAE1L6608QuIeGQNJJ5hK9tzNyuTsvmgLuBOVKL9WJcWsmYIgJMbUs69XVYtZ9s/oEa7BTLvx5fIJbT4K+s75bwPpDa6EGujsGYx+0c0QYHzKwrP47pOH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366740; c=relaxed/simple;
	bh=uQ5IjdC0/0sr4uvZq6rqWPRVZFyaXSCMGVyJXZdpc34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scfCIcfgyx2G0DuGExocjA7l/st5pKIWyz/nFdQ/mmGjtJ6r3q5fLCHVvZNR94hSwkj7clME4l1j/XnkbriTibRHFJpqTW+4Egci5s5fUdFw4AdI0xLX8zq6g3F1SEZfq0/B1jCXiq8XyH/En+B9nt+b/c8QsFurpILWWuVUq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2hNPtot; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39d9de6e-7d22-4a55-b27d-559a86dd5f7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748366725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAjoxEsRlDCDlqlmFJoAdt5aERhkKmPId4/7QntiMMw=;
	b=d2hNPtotSrIoBjaeVENNwvflmoh+rZf7uPzuH/0tBb4zDiEDCvn32+40F1+b+yu+64SnY4
	G9IWLPLm+EqSeql+q5bRtlsePFxb5HRMn8pR0WfUowGzLmZGAha/7dhqIAgeqyLWCzGDkY
	m2A+yL/wm0XNAqT5/a6p45Hy4GAHZKU=
Date: Tue, 27 May 2025 13:25:21 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: timer: xlnx,xps-timer: Make PWM in example
 usable
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/27/25 13:15, Uwe Kleine-König wrote:
> With #pwm-cells = <0> no usable reference to that PWM can be created.
> Even though a xlnx,xps-timer device only provides a single PWM line, Linux
> would fail to determine the right (pwmchip, pwmnumber) combination.

Well, it's OK if you are programming the PWM from userspace.

> Fix the example to use the recommended value 3 for #pwm-cells.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> index b1597db04263..d36cbf0efbd6 100644
> --- a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
> @@ -82,7 +82,7 @@ examples:
>      };
>  
>      timer@800f0000 {
> -        #pwm-cells = <0>;
> +        #pwm-cells = <3>;
>          clock-names = "s_axi_aclk";
>          clocks = <&zynqmp_clk 71>;
>          compatible = "xlnx,xps-timer-1.00.a";
> 
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>


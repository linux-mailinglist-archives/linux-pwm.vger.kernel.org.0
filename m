Return-Path: <linux-pwm+bounces-4858-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F06A3111B
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 17:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3106E188798A
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB561D63F9;
	Tue, 11 Feb 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1pXt6cd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C01EF01;
	Tue, 11 Feb 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290578; cv=none; b=be0MC2sBSOJTC2nOU2Z8Og50ch/d5uy4dqXVFCy4xhVOgSjBxqyqt4sbgFG0jwpBB6ksj76jTbOeJ7GEoFc/Vuj/8b8wd31Q7PQGU1y7gVm17o1WUHRRIDnTAJDzsGy7QNP1Po8z5+/RbElVwlKx99g1J4/1lOXOetQKvgePc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290578; c=relaxed/simple;
	bh=1apOfVZ6LTpZYFLpFXmf153RBYS1MxNBPKu94D2rOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOBxprtrnoqBfgR8rNfQ8vLFwFw+dfFJ1xb8p1+6DrLnjmbJqx8GXNHQUxR9Pd5xV/s7WPyP1uzZ+LlPEHdGvHQlIr/vNfohvtySOV26X+mobkMySZ4XhRYx9mfI6/+b+0tCkdscmojyRkhkUoiq9cRG+a9XLtnbSLBskgwONDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1pXt6cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F5FC4CEE5;
	Tue, 11 Feb 2025 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739290576;
	bh=1apOfVZ6LTpZYFLpFXmf153RBYS1MxNBPKu94D2rOWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1pXt6cd9/NtBdoxZPnnvpY/oFOXH3Jxv9rSmmrs21uhFjOpUfDWg8rbeAtZfbL+4
	 BVxN/UZCqGGAHACVhmGiYwSrAUlQrbq6DXvlEXKCqp5q4ZRzlyJWWNp+QvXax+hq7W
	 InRZ2k9VpICPC3EROPXxFhw5WqRpn8PAMM6h6wMUJChBz92QTpgtPF+KzTiCGqD7XN
	 YPme+lhIb7d98mXJ6+2IT+md14M2EuXfXQLbXcJv8Q1EnCpoTvBmTGt9ta7kb/4pbL
	 2cQGd37A46GtHtST1WcmxAfsB1eagOqEVwWkrf6xrmqsJ45LsaLED04DZ15pnkvfQl
	 PUfSlEtM/RtMw==
Date: Tue, 11 Feb 2025 10:16:15 -0600
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: marvell,pxa-pwm: Update to use
 #pwm-cells = <3>
Message-ID: <20250211161615.GB354180-robh@kernel.org>
References: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
 <cb799d8a5bb284cd861785a691b8d5e329300d99.1738842938.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb799d8a5bb284cd861785a691b8d5e329300d99.1738842938.git.u.kleine-koenig@baylibre.com>

On Thu, Feb 06, 2025 at 01:06:26PM +0100, Uwe Kleine-König wrote:
> The PXA PWM binding is the only one that doesn't pass the PWM line index
> as first parameter of the parameter cells. However this can be upgraded
> to the mandatory binding for all new PWM drivers without breaking
> compatibility for old device trees using #pwm-cells = <1>.
> 
> So bump #pwm-cells to 3 with the (undocumented) promise to keep the old
> behaviour for #pwm-cells = <1>.

Why make that undocumented?

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Duje Mihanović <duje.mihanovic@skole.hr>
> Reviewed-by: Daniel Mack <daniel@zonque.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> index 9ee1946dc2e1..74f2d5964742 100644
> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> @@ -25,8 +25,7 @@ properties:
>      maxItems: 1
>  
>    "#pwm-cells":
> -    # Used for specifying the period length in nanoseconds
> -    const: 1
> +    const: 3

Note that if we apply this and not the dts change, we'll add warnings.

You could instead do:

oneOf:
  - const: 1
    deprecated: true
  - const: 3



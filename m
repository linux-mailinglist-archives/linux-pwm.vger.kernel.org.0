Return-Path: <linux-pwm+bounces-6561-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32589AEC088
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 22:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF973BE4CC
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F4201266;
	Fri, 27 Jun 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDlCWlVc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306715E8B;
	Fri, 27 Jun 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054545; cv=none; b=LRLLFMqZPSz5LzF6O5Lq8BZqqImJSqABxmo+asjxNUf4zpi0HsEtQTjfeFgw/sWa4hM5ZsxyR58Aar2LMHmHBgtBs/FNezY8VuYAj9CYMNIYr6BY/wld3uw2ftse1WMRoygpes/k2/l7Vj7GD9y5hWeJZLBFOLeZlhjWfzWaGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054545; c=relaxed/simple;
	bh=9J/SexegBYQTZd2KoTPTstXhcyF4Eldv2Z7ahO3a3OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QijICl7V8fn/PHNd/WAdA4Ip4kSUO60hCqFHOi1VsnjRJ4mCtbIsncCNd3gUrOWQlfCH9o72zZEmRr6eJKRRgWgalrne7c4WH7obRKPBEHaa2Z2ezSaVl44SFnvpkRG2EtMwmZhMVp9DsP4TtVlAcknvdtyb3zNFx0mbLWN1FyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDlCWlVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D95CC4CEE3;
	Fri, 27 Jun 2025 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054545;
	bh=9J/SexegBYQTZd2KoTPTstXhcyF4Eldv2Z7ahO3a3OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDlCWlVcepWCHva+Y5h93NEXXRFpMNVPEo4PoAhuMWsIuccu9CDLuqr2fgxZyg0Pi
	 h/SNtldmZIcpkeVO38rAC8vwFKDaphO6uuawJ7VLmHoAQCabybApDkNk3H9NnESgUg
	 zeY1BFg17NXzfLq0HMpYXt7erM87rOkuLsrw/pIFYKQrmGXjVaAUzPIiafGgkbqIvH
	 7n0LLvi9rIuNELy3zWvfG03zd0Flj7ZNmL/GbrvZObMndxK6C/adGdveLQBpMloxtT
	 GJKV4J/PBaUDZttMHH9tad/A14MAe6zu6d1lgu1lexzc/1aaeocG0WOm65IRd5z8u3
	 kXHN/m2NEKFZg==
Date: Fri, 27 Jun 2025 15:02:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
Message-ID: <175105454403.4088109.10563926694624108240.robh@kernel.org>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621172056.160855-2-marek.vasut+renesas@mailbox.org>


On Sat, 21 Jun 2025 19:19:55 +0200, Marek Vasut wrote:
> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
> blower fan hat which can be controlled over I2C.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Implement dedicated binding document
> V3: Update the description and pwm-cells
> V4: Drop | from description and fix up pwm-cells = <2> in example
> ---
>  .../bindings/pwm/argon40,fan-hat.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



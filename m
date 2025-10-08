Return-Path: <linux-pwm+bounces-7396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E908BC531C
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4036919E2CF0
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0E284884;
	Wed,  8 Oct 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nim7KjV8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D7284670;
	Wed,  8 Oct 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930087; cv=none; b=rO0rzAfuptIxSMI/c9Qjvit7JruOK9p8OmvqPCsHeFttU5WpMUIWC6TehHSeICpkFUPBFP+Wg7YST3bB3enzR2mI0xzIKmPVQSnuRbOTPtFjVHfWpcYiWnLcbqpyF0q6LE7hIXzQxcEoVeT9SXMX/seTntkl8LPPNHEhdtGdUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930087; c=relaxed/simple;
	bh=VqQWCPYNSTM6xThvln60pCzT1OI0Be5tYbJN9o0YF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH6aN+K9cjKpMuaSSAHJcaMEoFAoBwmYLlx+qn5lS0xLrVZrqVkyloRzCoJV7uKOxqRJW5vrgscWJQRI60BhRAn15TPF3QHaHGm9Ji6rSxyDUwS3szDpe5Tsz/rvVsoD7GnTyJHG3Y+mat6EmtOwl7JpW7Qj4G4V4BdNvd0S0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nim7KjV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22587C4CEF4;
	Wed,  8 Oct 2025 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930083;
	bh=VqQWCPYNSTM6xThvln60pCzT1OI0Be5tYbJN9o0YF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nim7KjV8hYx1euW5he36Xt760dBApKdo7dcsI9zXp/d22h2rTpZVF3pFRZ3eHhE+I
	 Wx1B2Kx3Vw3OMRXhsL/szWCk8+vczNjyepst/EeV2xS51GD6CGrYJlRDle+86Y9QZh
	 vJ6wqnoM/61gV+IVbWlEOl+2Mwzf8BdrHG14cpXUg5qhJBH8uOlSkphPOQzkepS0nK
	 vHpE0oGBlgCxy/QFriPWOVwFxAgWHcG02qZxNOB5jrctxPXeYPYLRgxE5b52McKVr1
	 S4wgSKGL5xr5eoPAA33qyh7W3dVJdSHa0bmJv12cbXp6r0kbQUtptUziyVxYxCg/Ae
	 TzphinhMFtSVg==
Date: Wed, 8 Oct 2025 08:28:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v16 4/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add
 compatible for ipq5332
Message-ID: <175993008127.3405051.13877164117014075285.robh@kernel.org>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-4-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-4-300f237e0e68@outlook.com>


On Wed, 01 Oct 2025 18:04:20 +0400, George Moussalem wrote:
> The IPQ5332 SoC contains a PWM block which is exactly the same as the
> one found in IPQ6018. So let's add a compatible for IPQ5332 and use
> IPQ6018 as the fallback.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



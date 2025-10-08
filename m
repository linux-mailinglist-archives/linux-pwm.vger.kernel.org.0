Return-Path: <linux-pwm+bounces-7399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73563BC5383
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C623A5529
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0087284687;
	Wed,  8 Oct 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL634/lJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90046224B09;
	Wed,  8 Oct 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930299; cv=none; b=svC1Rh++1nhbm1Ios3/ghPDU2Aa1p5y7EhICPZpPVRnbH/C2fAfc09p8ytA19vaN0I5QmRFNsoisiTHRWAGuBVeI/n+Wtbsnz2/drQvioq70b2IVU8edGTQox2eMFtVVShJVVV8L0pKygF9+4S4o/kmxWZUPY8B8og69gaRvqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930299; c=relaxed/simple;
	bh=r7DLtYnTyUmwk76ozM37yxs0kti+NVMRthxTc5cpnbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHM329TnGdkbHqVb3tJG6ex9Bm8MYubAfEUXpfSz+jKTpTL5bRAmm10O+qimQhuZriBS5HzaR07vl3Ag9h80v+YV0Afrooru32rrPsVsLZFgTGw/HcHV8cnHmWnZyAwjBm9mD6aPmBXR2FuFpn5Wz1gm/Jyz+vF8d6HzgVAK4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL634/lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023BCC4CEF4;
	Wed,  8 Oct 2025 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930298;
	bh=r7DLtYnTyUmwk76ozM37yxs0kti+NVMRthxTc5cpnbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QL634/lJGBxTgsXJwKgnUOkOtspYqImlIG4Tlpp+JhPl1xXuYpvBQssra1vuGzQtY
	 kjiskEYwvlrE6B7X+0xBaSzv0VkITyEIizwSOclVTYg5FwUUUHjtRS6Y2uINY3Gb1g
	 8QnwicNnHEP3oihlaceO9/WzxVxN/lVl0LHSVfSv6g2u9/JZ6URubNftOyb/p2COQm
	 jCq1Pzut4K03psEBL0TVkQx3qG9QvT/EmTvr0xGRqSQZ/A/3ZF8wU7EW44hi4UWjwD
	 tpNRi0uElNvsdh/N89DypIrg9R9Jh49f/dgw/R+ubCRjRD11BAFkNz9EETMyz4zFUp
	 +XTE1CXtMGXDw==
Date: Wed, 8 Oct 2025 08:31:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v16 3/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add
 compatible for ipq5018
Message-ID: <175993029652.3409106.5685408571837686502.robh@kernel.org>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>


On Wed, 01 Oct 2025 18:04:19 +0400, George Moussalem wrote:
> The IPQ5018 SoC contains a PWM block which is exactly the same as the
> one found in IPQ6018. So let's add a compatible for IPQ5018 and use
> IPQ6018 as the fallback.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pwm+bounces-7397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF8BC533A
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD54E9CEF
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B7285061;
	Wed,  8 Oct 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFoC7pcs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4328504F;
	Wed,  8 Oct 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930123; cv=none; b=Xxl/Jk/pZxzzkV1Gn1stfbKNPnzaCx0TWn5N23sWuNtYR2kAQobr/RzGLTh/kdDtHgzk4cALhhT+QVn/EzFSqKT/gs94b3+vJa4APf+GElbEVQMw7ZKhaTZjhuQW2QMu0tKjWRXWmpmyA+UdRU37M/bcEQs7utR9jwe+NaP5izI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930123; c=relaxed/simple;
	bh=5VI0Qe4pumAMIWGqV/sJgLN0/InDus/63WaIN+igxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF25oksVU+tMFHMCPMQIOA5b6Ljgrzh9gHWts6NHijAPBGph7jt8z5HgyXPvX/si0oujOBlvsfv1tbynnSqAYK+9zDLHvQi6S7OjzzZYegladLbk4Ye4kKKNwy8dHhlRNCmYz62cNatThIIcf74h3t8tUAtWsXDPz3DPi4vRl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFoC7pcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C9C4CEF4;
	Wed,  8 Oct 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930122;
	bh=5VI0Qe4pumAMIWGqV/sJgLN0/InDus/63WaIN+igxyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFoC7pcsvlX5j//2T2mjRSOUYWB6wPXwmKNP839fCJRpCYKYz9io1sHrakuf/9KYH
	 LjokgfyQykHd/1IJ5rmESrZOxU5vCrG/Gc9AZ0xdHjTD+xK5dh38FYVNPjOagskK0u
	 AZTA+Uk0qLMSBi7RP7rtAjn3OUy5RHu9PUtJbAk6t8abvJSnqrxMQzEZWP2bWHFfiT
	 7Z+Y3qs8rXjDk3XgMsLmUIMKkectPh8+LeNZnQ2YkhSpsRVCUAGuJFO0TpkNiULlZw
	 7ldfx7sx4tqPH9AE43nzmiUgb+r4oPIYTA+x2koYgC0OafusbrpTJgSrzIzpJtQkzo
	 lw0uDyot/sgEg==
Date: Wed, 8 Oct 2025 08:28:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v16 5/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add
 compatible for ipq9574
Message-ID: <175993012043.3405904.5217021551347655915.robh@kernel.org>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-5-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-5-300f237e0e68@outlook.com>


On Wed, 01 Oct 2025 18:04:21 +0400, George Moussalem wrote:
> The IPQ9574 SoC contains a PWM block which is exactly the same as the
> one found in IPQ6018. So let's add a compatible for IPQ9574 and use
> IPQ6018 as the fallback.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



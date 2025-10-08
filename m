Return-Path: <linux-pwm+bounces-7398-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2ABBC5374
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A063BCC8E
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A302284896;
	Wed,  8 Oct 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm5NNNjW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3B2629D;
	Wed,  8 Oct 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930278; cv=none; b=ODnv45nD6YTr0MkaKQUhOhD4ue5/1nI6fGWTuvBmtk850yosrCkIyELVCvi80GfEIyI+gxnwdcIi1DMQ51q0w0/AUBa+88c6xEmpMMkeizfSOnacRInji2l12H6TjRmjXTv9HbE/pnU9uCm9Xd6JQwkdQ6sEGNstq6mEHYyBhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930278; c=relaxed/simple;
	bh=Hp1IlRzRa/6QFhN6/wCc/ZoswzZmeJcHmZyTbybM9Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8ZMNvCnoKIx9sUZdbG4z1BDHwencvfby3nh7Mkbn647Sw2rLDLfMz8qJkPG8nNOnhaHzlh2vQCfFH1ArcOGCAB2+DnwETmJDzMaZA/kHk6jCQslu2UnRBTw0QrJVOthApkbu+E6yspiYyKRsF4XPwX+gNL9dc8YiJDmM3Brvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm5NNNjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F2AC4CEF4;
	Wed,  8 Oct 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930276;
	bh=Hp1IlRzRa/6QFhN6/wCc/ZoswzZmeJcHmZyTbybM9Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rm5NNNjWXyvLsce47TGSYdblCdoOnIF+pGtDT9BRnfmKoNxOBVQeR23UxAF9jLISa
	 gCrEIDX55s1hdHCGilUfkO0AVb6gx4mj+GY2Ltbm68Bfk4eKV53AJHQ/r5NeZnYBmo
	 PHydbsIyn2pUSDDgurvN4pTNIUyVYNZCcJrkksyu6UKHI3hFltS1kOiHNUOoyDdieV
	 jNlNyZzx8+NGnVfMMoxNUL1ezUa+xY4BTj/fiCH+c5VUBDfVKEirRR/okYZZaHeRym
	 4qNFUOWee/JxxIugUHdgwLrlFqm7aar9Tg/LX0Ni4cXu9kZNiILtg4KoVNgw1Ch/PR
	 9K4b904p9LztA==
Date: Wed, 8 Oct 2025 08:31:15 -0500
From: Rob Herring <robh@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 3/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add
 compatible for ipq5018
Message-ID: <20251008133115.GA3406112-robh@kernel.org>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>
 <DS7PR19MB8883089D146F101AB2F7F8DB9DE2A@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883089D146F101AB2F7F8DB9DE2A@DS7PR19MB8883.namprd19.prod.outlook.com>

On Sun, Oct 05, 2025 at 09:07:39PM +0400, George Moussalem wrote:
> Hi Krzysztof, Rob,
> 
> Since I have to submit another version anyways, I was thinking of
> changing from a fallback compatible to a list of enums but wanted to get
> your guidance on this. The driver needs not distinguish between the SoCs
> and no SoC specific match data is needed. Would you prefer as proposed
> in below patch or switch to enumerating them in the bindings and in the
> driver?

If the block is "the same" in newer versions as you said, then a 
fallback is the correct choice. No match data or the same match data is 
another clue.

Rob

> 
> On 10/1/25 18:04, George Moussalem via B4 Relay wrote:
> > From: George Moussalem <george.moussalem@outlook.com>
> > 
> > The IPQ5018 SoC contains a PWM block which is exactly the same as the
> > one found in IPQ6018. So let's add a compatible for IPQ5018 and use
> > IPQ6018 as the fallback.
> > 
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > index 1172f0b53fadc140482f9384a36020260df372b7..acbdd952fcca53368e3b594544df8d3dae8a06b3 100644
> > --- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > @@ -11,7 +11,12 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: qcom,ipq6018-pwm
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,ipq5018-pwm
> > +          - const: qcom,ipq6018-pwm
> > +      - const: qcom,ipq6018-pwm
> >  
> >    reg:
> >      maxItems: 1
> > 
> 
> Best regards,
> George


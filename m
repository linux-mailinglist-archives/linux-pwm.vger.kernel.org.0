Return-Path: <linux-pwm+bounces-5632-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A6BA9565E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 20:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20791162493
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91F1E5B9B;
	Mon, 21 Apr 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgqHsREg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF141C69;
	Mon, 21 Apr 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261977; cv=none; b=vCQ+v1mJpsBlqj0hrzlmYTnROoEs9Bagc8h9Ag6znwrxK/rUf2IqEvBI7wCRYoMvriM+R4+32FM4kLsB2A9QqxDkT46dP7CdMo8mIWBP3Y1Ctt4rFeveYWKoWS6yZO/6YtYWMuVfrXfh76dSRLheWFwIBRbd/Cx5V7TxTLEMBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261977; c=relaxed/simple;
	bh=CFk6Z7FZXx37yf9mMuNjTrwa2SXeuJ5JCnJbDuFR+iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehtundBvOkh0dKBWzP713ddLTGR9t3eNPfgc5JW8jJ0ldmgyuVCEtUI+YKtWeSzuy/elE5uQQAqkwuVFz2Og38y4JXYgz0zfD6NIkA+/HZeQh6PkzjJBjvExdESh+sC4pX9qARWn0CC0GDab2dDS3r4k7NA6HEvatqg3h6T8p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgqHsREg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731CEC4CEE4;
	Mon, 21 Apr 2025 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261976;
	bh=CFk6Z7FZXx37yf9mMuNjTrwa2SXeuJ5JCnJbDuFR+iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgqHsREgj0KUR7iOxrjGoGSOOXZlSb+0sjtSyrDwRZpMjRNwxYw4qkxadYy2rCHfY
	 KyKvKWPjNF9loFfFrr8yZn2jluAFRYmCZj6tBiNGJOcO7qClxyS0ht1Evq5c1moSOh
	 hYNaYTHwxXSMRG8TdOSNZ377WMUo7PD9bCY+fV63Na11LxvztEm1Ih+DXysNFa+wjE
	 Q9ilSjDsB23+DjJy3kllnaN5k7YO4YjT2iV8N3V1fMoluc/AWiYjMiCZwYTkkzs+ha
	 KSOWNj+UYRF6r0R+DJcjvXn1xGSRd2P7kUTu+nqNWiI8xHYzoQW7A5/+iDAxSjMPLF
	 zgaH67HBgGC3Q==
Date: Mon, 21 Apr 2025 13:59:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	linux-input@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liu Ying <victor.liu@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-gpio@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 05/17] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Message-ID: <174526197404.2623384.13566679975477936352.robh@kernel.org>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-5-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-5-3a799c3ed812@analog.com>


On Tue, 15 Apr 2025 15:49:21 +0100, Nuno Sá wrote:
> The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> programmable logic, reset generator, and PWM generator.
> 
> We can't really have adp5589 devices fallback to adp5585 (which have
> less pins) because there are some significant differences in the register
> map.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       | 47 +++++++++++++++++-----
>  .../devicetree/bindings/trivial-devices.yaml       |  2 -
>  2 files changed, 38 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-pwm+bounces-5967-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C1AB594D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406D2188F9EC
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B872BE110;
	Tue, 13 May 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwTZl3AJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF271F94C;
	Tue, 13 May 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152256; cv=none; b=tqtnlVHIMW6juz/UazSuhYRA1AhSy8yLUveaBHiIs9y3qkevWCRp4S6ph2Up4BwoWuZJeNCJ+rYvPtDAzFgpyn8RK1gwmrxMszYE8WQ4dZ1+2Ezb3dPEqfzi9Ma6PtRSl0BcEjRwlwNsWTOaQTz58yFXVqqQEMIoI5HNQV3PXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152256; c=relaxed/simple;
	bh=0ep/4ml8QkHuQs+cPIAzF4/IRuv0QUq6k6Ms2Zmv1aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmsItwiys1pM7tm1QeIGWYzbprUFgJdxptkdvagOHtVydvXSuF5hQfxk32ujlgcijXo84uInyE1Ua4k1JFAEtWkvkeC3RkcqwatuihrGYnX34h3H3w21O8ufrmVUct2N88DH31FNwfiaSbi5L9HKYwoDNyVQzLhZDqPLn8PpThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwTZl3AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AB0C4CEE4;
	Tue, 13 May 2025 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152255;
	bh=0ep/4ml8QkHuQs+cPIAzF4/IRuv0QUq6k6Ms2Zmv1aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwTZl3AJQoW5zQuoy7xlVK2zlOgDwP1C9jQY5KayJ47jTpQBiuHoh0uA6YBSjonBE
	 Zg6JD/5051ffZ2BRk/PBAfoodc7RD2ormiI7Ku3i3QTS0fHZWW38a5Ti42G2/Fl/F+
	 ZC2u+ATh26VaILeGqIOrqwqXXMzhDy43svhXGYpfPJO5K1iTwCpzYH861Cryh2o0Na
	 bAOLfaWDdUv0tz1bIdvZ3YQVEsZfh9UvKoK0bgA0iyg6EArohuKKsmIoXsWxHPOEkI
	 KpOYp0i1WLLxgc69p8g0/gopTrPWs55uHnQwdlVw3wfmm5s8AF6GOn8ch7+WH6SjJf
	 Jq21AcTBvA5zQ==
Date: Tue, 13 May 2025 17:04:10 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 04/22] pwm: adp5585: don't control OSC_EN in the pwm
 driver
Message-ID: <20250513160410.GS2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-4-092b14b79a88@analog.com>
 <20250513152655.GC23592@pendragon.ideasonboard.com>
 <f3d6bd26e9505855051391c6bd35bb756eb59bef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3d6bd26e9505855051391c6bd35bb756eb59bef.camel@gmail.com>

On Tue, 13 May 2025, Nuno Sá wrote:

> On Tue, 2025-05-13 at 17:26 +0200, Laurent Pinchart wrote:
> > Hi Nuno,
> > 
> > Thank you for the patch.
> > 
> > On Mon, May 12, 2025 at 01:38:56PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > The adp5585 is a Multi Function Device that can also be a gpio
> > > controller and as it turns out, when OSC_EN is not set, we can't
> > > reliably read the gpio value when it's configured as input. Hence,
> > > OSC_EN will be set during probe by the parent device (and cleared on
> > > unbind).
> > > 
> > > Moreover, we'll add support for the keymap matrix (input device) which
> > > definitely needs OSC_EN to be set and so, we cannot afford that disabling
> > > the PWM output also breaks the keymap events generation.
> > 
> > I think you can squash this with 03/22 if you send a new version. Moving
> > the OSC_EN bit handling from the PWM child driver to the MFD driver is a
> > single logical change.
> 
> Will do... happy to reduce the number of patches in the series

+1

-- 
Lee Jones [李琼斯]


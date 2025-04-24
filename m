Return-Path: <linux-pwm+bounces-5695-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CDA9B362
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92497189847B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A6280A4C;
	Thu, 24 Apr 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH7gpb3+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6227F741;
	Thu, 24 Apr 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510832; cv=none; b=EVAaLr0Zb51eslWQVHnOWPrTwHMfmpWecI6viDdv8LyHkOIueueVhDFftFaX1NDMItalH1AJhjD0guRhIvYeQ15FJlkEWVtC29NRea0yxcsiOfeGud4AmMi+g6zCWlfyuIdQJKp71YR8D0DkjceHsBCqYhIThogE+7v51V0aATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510832; c=relaxed/simple;
	bh=u+V3fTgG06hwrCHEbqKSXdFzqgVK2Sp69Gv2OEFHhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRn40POFEZNR+5lCkpxUL99+G6UKVvPctJhXItzDTyI2umVIBPclEoVFPHK2hdrwilv7SAMtJHOtoaK0741v/kKPVi/aDvlCEeH/x2WnzHMzn8N4A3As1iu9UOJwuKalzlsHghHZXUrc0hjGyWRnT/QkIuczAX43xOUP8NNuPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH7gpb3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2455C4CEE3;
	Thu, 24 Apr 2025 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510831;
	bh=u+V3fTgG06hwrCHEbqKSXdFzqgVK2Sp69Gv2OEFHhfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH7gpb3+Z5SM88t6XGB1A1+9ZXTzbWvlnS9R1TtIspIsg0TCa7SFzRb7pWwFwWdN2
	 tC5AAPACa6unuubzwIHDAoGpYvGwa65ezz0pfJVIx/h9OkkSuf2L8ZU1cbM3R6Hal7
	 sym4tKrS/ndP9hdmlflvPyWc4siQZEm5EvNnPCdOl1RwPuo6/51e7+se4s7yBrM2GZ
	 QCAE9ynczsKs9r43DFs7hDWhwDtHaDgLiJjW/13YWamtw5g4p/r6IxCCWwRkPbpOVA
	 lwrVUQMkomQ6P1UeT1M7XUwB8NKDAqegrYTxV7GGsO+Z7vmTU6pK5JZsRIhz9lLPI/
	 NgAhX+HP0RdFQ==
Date: Thu, 24 Apr 2025 17:07:06 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 10/17] mfd: adp5585: add support for key events
Message-ID: <20250424160706.GL8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-10-3a799c3ed812@analog.com>
 <20250421093310.GH29968@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421093310.GH29968@pendragon.ideasonboard.com>

On Mon, 21 Apr 2025, Laurent Pinchart wrote:

> Hi Nuno,
> 
> Thank you for the patch.
> 
> On Tue, Apr 15, 2025 at 03:49:26PM +0100, Nuno Sá via B4 Relay wrote:
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > This adds support for key events. Basically, it adds support for all the
> > FW parsing and configuration of the keys (also making sure there's no
> > overlaps). They can either be part of a matrix keymap (in which case
> > events will be handled by an input device) or they can be gpi's (in which
> > case events will be handled by the gpiochip device via gpio_keys). There's
> > also support for unlock keys as for reset keys.
> 
> There's lots of code below specific to matrix keypad handling. Please
> move it to the keypad driver, and keep this driver as lean as possible.

Exactly this.  MFD shouldn't need to contain anything that should be
handed in the leaf drivers.  Keypad handling should be processed by
keypad driver, etc.  If the GPIO driver needs to have visibility into
keypad API, add some exported helpers in the Keyoad driver.

-- 
Lee Jones [李琼斯]


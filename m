Return-Path: <linux-pwm+bounces-5697-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD47A9B3D7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D71883C9A
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE06280A50;
	Thu, 24 Apr 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZjJBYKPw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8A27FD4D;
	Thu, 24 Apr 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511854; cv=none; b=VRfrmYzP/jis+4us1grUd8mFWdjYemCD+nkLf/DDJELV2YQ3BD6x3VPqMeULzVzHf398HDacGJpeUXlaYIG45IPvdM3Q85+QPd9nzHrqoW6ybGvaxV53YdSeYVzTWgw2mhyuxCOzgjHTmfUEviddCJBjAxBgVMUs4I9d/H3aZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511854; c=relaxed/simple;
	bh=ShPdx7dUstrGIyl813wz9lLDzwTwAeUEQ4npqpR4uZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShYzh47ihef+BYJSA08BixJWtn/Ay+GJYrqVzUOBsnrXce0bHD4YgGm4r9nRLCo6zr11cWcmFvsNxSnMVHSNi1hXUxz3Qbj5BX+VYgdSu1X9vxyLCV3RBXGqTBeQaTyMM9cqcG1ttxchhQDSah1BuC2Y9t2oFKwEr3VhS8gWqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZjJBYKPw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17E2FF01;
	Thu, 24 Apr 2025 18:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745511846;
	bh=ShPdx7dUstrGIyl813wz9lLDzwTwAeUEQ4npqpR4uZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjJBYKPwRXqqZ/m0aUkkilPxYMaqOv93aRMPyMsBBL4yuY1n//OnQy9+yF1+z/WFT
	 vDL3ud/KiNsQEstRuUIfgNYfYEI7r6IX/N3g937dAhTm75wfipWpiqRLbD12aeIT50
	 o5K//ePxDSCbaZSDL+M+8zXHgJW3CldNqcgc8rsc=
Date: Thu, 24 Apr 2025 19:24:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 10/17] mfd: adp5585: add support for key events
Message-ID: <20250424162405.GK18085@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-10-3a799c3ed812@analog.com>
 <20250421093310.GH29968@pendragon.ideasonboard.com>
 <20250424160706.GL8734@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424160706.GL8734@google.com>

Hi Lee,

On Thu, Apr 24, 2025 at 05:07:06PM +0100, Lee Jones wrote:
> On Mon, 21 Apr 2025, Laurent Pinchart wrote:
> > On Tue, Apr 15, 2025 at 03:49:26PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > This adds support for key events. Basically, it adds support for all the
> > > FW parsing and configuration of the keys (also making sure there's no
> > > overlaps). They can either be part of a matrix keymap (in which case
> > > events will be handled by an input device) or they can be gpi's (in which
> > > case events will be handled by the gpiochip device via gpio_keys). There's
> > > also support for unlock keys as for reset keys.
> > 
> > There's lots of code below specific to matrix keypad handling. Please
> > move it to the keypad driver, and keep this driver as lean as possible.
> 
> Exactly this.  MFD shouldn't need to contain anything that should be
> handed in the leaf drivers.  Keypad handling should be processed by
> keypad driver, etc.  If the GPIO driver needs to have visibility into
> keypad API, add some exported helpers in the Keyoad driver.

To give some context, the ADP5585 is an exotic device. It has this
feature where different functions (keypad, GPIO, ...) can generate
events that are all pushed to a single hardware FIFO. The driver reads
events from the FIFO, and processes them accordingly to the event type.
Handling the FIFO and reading the events doesn't belong to any
particular leaf driver, I think it makes sense to keep that in the main
driver. Processing of the events after dispatching based on the type,
however, should belong to leaf drivers. I'd like to see less
keypad-specific code in the main driver, but some additions are likely
still required.

-- 
Regards,

Laurent Pinchart


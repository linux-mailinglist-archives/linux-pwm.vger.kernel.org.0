Return-Path: <linux-pwm+bounces-5698-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2AA9B403
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC31BC009D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856128DEE0;
	Thu, 24 Apr 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9uTxeHY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E928D83D;
	Thu, 24 Apr 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512117; cv=none; b=m0Q2PczYlJ97m0+wYNELoVSCGq7IDPUGv3pPXpLhjRL8L8nOKncxDTuaiZshiJ3QwQHMZV9h9caPJo6S1L4jfgGVab4m/uf1rt7ixR+0o1pNyr2AbvF3ImXXUB73RUQW/gLT6YE11SiXPXDd+1w57S1ib68Y+ssAW5gBZdEmTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512117; c=relaxed/simple;
	bh=/l8kCT4PyYuewfYXxdP7ynV7Oc1zF9+nJcURlSo0zOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSmNd5TMAixkUHQ3GHtAtTfUWESga6au7Th6xdAx6MLGFfWpFNYiU39zAZN/lvASDGjVvJSj6LfGf2giQ3zFuUrJlLVd/zI0yAP1pwvsGN2RpO4gOwtpxCuK3WNL2eTiKexlgRHwOHppvW4V40BG7O1fNNY39wcz2KSTOit45oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9uTxeHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CEAC4CEE3;
	Thu, 24 Apr 2025 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512116;
	bh=/l8kCT4PyYuewfYXxdP7ynV7Oc1zF9+nJcURlSo0zOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9uTxeHYvLxLERI3BcWRoPfuI7IUjZRUbnvNJZI7s+TwU4lT8lgnANIXbe3E3PKc0
	 4eNa3bPYcmG+0XpINt/CDFZMCJCKI3ZfINBulEzQRVO3pxql9m6bRawfBf939jrGGd
	 prJeIqRNezMKP4qxjsD4/57rDg2Ls+bSPCggAVsTpNTGdQDjtbCfjqaiD7ujoKf9+e
	 AwONcV5tfBQyPiYmrXqvYsp+WkC/Da6kpK0tv2Gv74H4clxz+9AH1dNxNeme2I4XMd
	 MOG2fYgOrY+KZ3Otl73TguVYG9Drp4BXg3WO5SF71qkohrMDy9n74fLcVKNza5lYAR
	 RF3I3dE3EpCfg==
Date: Thu, 24 Apr 2025 17:28:31 +0100
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
Message-ID: <20250424162831.GN8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-10-3a799c3ed812@analog.com>
 <20250421093310.GH29968@pendragon.ideasonboard.com>
 <20250424160706.GL8734@google.com>
 <20250424162405.GK18085@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424162405.GK18085@pendragon.ideasonboard.com>

On Thu, 24 Apr 2025, Laurent Pinchart wrote:

> Hi Lee,
> 
> On Thu, Apr 24, 2025 at 05:07:06PM +0100, Lee Jones wrote:
> > On Mon, 21 Apr 2025, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:26PM +0100, Nuno Sá via B4 Relay wrote:
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > This adds support for key events. Basically, it adds support for all the
> > > > FW parsing and configuration of the keys (also making sure there's no
> > > > overlaps). They can either be part of a matrix keymap (in which case
> > > > events will be handled by an input device) or they can be gpi's (in which
> > > > case events will be handled by the gpiochip device via gpio_keys). There's
> > > > also support for unlock keys as for reset keys.
> > > 
> > > There's lots of code below specific to matrix keypad handling. Please
> > > move it to the keypad driver, and keep this driver as lean as possible.
> > 
> > Exactly this.  MFD shouldn't need to contain anything that should be
> > handed in the leaf drivers.  Keypad handling should be processed by
> > keypad driver, etc.  If the GPIO driver needs to have visibility into
> > keypad API, add some exported helpers in the Keypad driver.
> 
> To give some context, the ADP5585 is an exotic device. It has this
> feature where different functions (keypad, GPIO, ...) can generate
> events that are all pushed to a single hardware FIFO. The driver reads
> events from the FIFO, and processes them accordingly to the event type.
> Handling the FIFO and reading the events doesn't belong to any
> particular leaf driver, I think it makes sense to keep that in the main
> driver. Processing of the events after dispatching based on the type,
> however, should belong to leaf drivers. I'd like to see less
> keypad-specific code in the main driver, but some additions are likely
> still required.

Understood.  Let's shift out what we can though.

-- 
Lee Jones [李琼斯]


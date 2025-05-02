Return-Path: <linux-pwm+bounces-5799-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAAAA6C88
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640A63A0805
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44422A4F2;
	Fri,  2 May 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu9i7b//"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77A1FDA6D;
	Fri,  2 May 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746174661; cv=none; b=ng47eWSAuRL5aFySWDtUDFhENnzcy/csa4MXDxXLK2+KRBvoWFl0Qm7CMTWDYaiPpX1lD6vl9fkSVb51TwDOxO81hqzTkSKBCKWDFiBZOZxpbRwAfuwZK65S2kq79cR/V7PBLikkmmM67uN+5HE6zy2XZ5q+fVv0PViP9Vc0x10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746174661; c=relaxed/simple;
	bh=y99cWh1qDmMqrQMp2BU2xOYKTolCUcplKtnNhwXq0+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcvQWCwNPlYfIu1PdvZLzrMqUxD9VsfG5QkwJi6C3ykLRB2PRkcy0zTddR++6iroieP/p+wCaZRY6U19IvRM36rBNT5tuqHrNxyiz03/S3xVbhVGfR9nhqsw3wkfqtAjg07ra/MfIi4jlAis1DnDrIf8VGaY0A5khVjDIQGSyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu9i7b//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB5CC4CEE4;
	Fri,  2 May 2025 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746174661;
	bh=y99cWh1qDmMqrQMp2BU2xOYKTolCUcplKtnNhwXq0+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu9i7b//WchSHCjmeccyZz64THiNUNRQLSuP+sbxeoXXEd6a779TqU5lFvJtPsU7o
	 Hf0uJ9VCGELJ0kkKF2VPP/+9wW9SXc2eC06oWnbZEWNG1twLeVC6f0NZdnfn8sVIB/
	 EWfqHSJ2YGbGMnuIvw/0WEeJdznOc8QpLh4SgqrjYMepRMR/3vAfAyZdegtDAsP+J3
	 1cvd6UsO7On+EgFoUGw8M5i8iG5DQdTbnCn8oCYOUdB1ATeXBgaHBixnEktMy85Apc
	 uiS6/XqXSVrY6d+ipX3wRuXydD2pBJdX2cjOo8YchuK77/9luHWiZRjmmSNhV0iJbt
	 k1A8EeHJTJsKw==
Date: Fri, 2 May 2025 09:30:55 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250502083055.GG3865826@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <174610080338.3792828.16902042195346769114.b4-ty@kernel.org>
 <20250501140958.GB6838@pendragon.ideasonboard.com>
 <20250502071336.GA3865826@google.com>
 <d78a923a7da54292f98746c71ff84160a5c42963.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d78a923a7da54292f98746c71ff84160a5c42963.camel@gmail.com>

On Fri, 02 May 2025, Nuno Sá wrote:

> On Fri, 2025-05-02 at 08:13 +0100, Lee Jones wrote:
> > On Thu, 01 May 2025, Laurent Pinchart wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Thu, May 01, 2025 at 01:00:03PM +0100, Lee Jones wrote:
> > > > On Tue, 15 Apr 2025 15:49:16 +0100, Nuno Sá wrote:
> > > > > The adp5585 MFD driver was introduced in 6.11 adding support for gpio
> > > > > and PWM. However, the gpio part of it was already supported as part of
> > > > > the keyboard driver:
> > > > > 
> > > > > https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboard/adp5589-keys.c#L532
> > > > > 
> > > > > On top of that it also overlapped with my refactoring of the above
> > > > > driver [1]
> > > > > to drop usage of platform data and use FW properties instead.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [01/17] dt-bindings: mfd: adp5585: ease on the required properties
> > > >         commit: 3a2ea3e9f369bdae939bcccff67a77a6281dca74
> > > > [02/17] mfd: adp5585: enable oscilator during probe
> > > >         commit: 7353f196fd73b79e30ff750d93caf096ed660e1b
> > > > [03/17] pwm: adp5585: don't control OSC_EN in the pwm driver
> > > >         commit: 7c7e9f08a1a9bf16b6c1942c2e0cb919da855970
> > > > [04/17] mfd: adp5585: make use of MFD_CELL_NAME()
> > > >         commit: e72e9148d017535b39500d0aad624d0a0fcd2ce7
> > > > [05/17] dt-bindings: mfd: adp5585: document adp5589 I/O expander
> > > >         commit: 6da01b9d833c5efbce7c2e30dde276e0d29105f8
> > > > [06/17] mfd: adp5585: add support for adp5589
> > > >         commit: 382dc0327b8a9ee03c901df9b85134c68917becc
> > > > [07/17] gpio: adp5585: add support for the ad5589 expander
> > > >         commit: cff3cef09595001140bd29aedf33fc84998bf77c
> > > > [08/17] pwm: adp5585: add support for adp5589
> > > >         commit: 333b66fd3edfe18db4dc16041328a89144b73067
> > > > [09/17] dt-bindings: mfd: adp5585: add properties for input events
> > > >         commit: 7bdb41d7a85e1c6244da57d4dcc491df962ff3fb
> > > > [10/17] mfd: adp5585: add support for key events
> > > >         commit: 8814ac45c75fcce55896bc376a97b56f392925c3
> > > > [11/17] gpio: adp5585: support gpi events
> > > >         commit: 8f3d9b44c5c5ada312d0ef71ec0181011854a95b
> > > > [12/17] Input: adp5585: Add Analog Devices ADP5585/89 support
> > > >         commit: a53fc67a1e21a8507821263946b1d65687b0284f
> > > > [13/17] Input: adp5589: remove the driver
> > > >         commit: 216c99cf1002a42f896b54fab09823e8ba46b218
> > > > [14/17] mfd: adp5585: support getting vdd regulator
> > > >         commit: 63a8717f744d51ea0c8228e09db4233d48f2f9ba
> > > > [15/17] dt-bindings: mfd: adp5585: document reset gpio
> > > >         commit: 49c887f0547bc14eb50ba20e1c8acb7255af3b86
> > > > [16/17] mfd: adp5585: add support for a reset pin
> > > >         commit: 01c328823459456fb99469cc37f270f70d41fd2a
> > > > [17/17] pwm: adp5585: make sure to include mod_devicetable.h
> > > >         (no commit info)
> > > 
> > > I'm a bit surprised, didn't you ask for changes, calling for a v3 ?
> > 
> > Yes, sorry.  My fault.  Tooling error.  Please disregard.
> 
> I was wondering the same...

Found out what happened.

I applied them all to grep for the spelling issue reported by Colin.
However, I hit return (sending the thank-yous) instead of Ctrl+c (to
cancel them).

Apologies for the confusion.

-- 
Lee Jones [李琼斯]


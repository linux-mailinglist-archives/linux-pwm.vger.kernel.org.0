Return-Path: <linux-pwm+bounces-2852-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A7937471
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA1B21243
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BB535D4;
	Fri, 19 Jul 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iSOPtPQn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B52CA6;
	Fri, 19 Jul 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374604; cv=none; b=NLJmnUmKG+QbFDUS6PQF5LlrwtyLqaemTGQYbeMxqCrCTW8gRAotkLRUOuEbZPSejuPam59lEIWEvfVa4gYXFJUdVi3aWRw/HGT55dTFJHW5bx9E1s39/Z8bi9LgApuJGuIPTGdKQz3Q4PZT/1AcB/WEZFHhAaJ8rUz8KJ/QOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374604; c=relaxed/simple;
	bh=aC9MkwUDJk7T/TtXgzd8e6HDNqDjDkQL+GKqceDP1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1o/Wz5rPH5CijvWJqPSs8RKapv7Xd1IksU/9IPV/CkFcSpVPxz48Kk0zEJlhASGsHn3zwOclfmZFZ96nJDpfwSaCfTmZeVe4ebYMdChPYDzjms15jWqb78j3t6NxLJHJsCGVMMtU+JVGrUgHQ2RDt0x4S2RodqS9UFuZtgrZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iSOPtPQn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3CF85471;
	Fri, 19 Jul 2024 09:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721374561;
	bh=aC9MkwUDJk7T/TtXgzd8e6HDNqDjDkQL+GKqceDP1Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSOPtPQnAN2dN+dPrtvML40dvEnFrkSH/9buEzj8weB6O99NTguiVaDRAWzJKgbkl
	 /6qAPZZwbTGIeh8HhLQAcZbm47LQcoPXdY80ICPwbzH1whRI2dWu/PbvGXoyJUzpuG
	 3Ol5HkEZnWBSQ1bhVwVYc+2l1CIK2rbIWGbs1nSQ=
Date: Fri, 19 Jul 2024 10:36:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <20240719073625.GA12656@pendragon.ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-3-laurent.pinchart@ideasonboard.com>
 <Zpcu3+6Ar/zR78Ma@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zpcu3+6Ar/zR78Ma@lizhi-Precision-Tower-5810>

Hi Frank,

On Tue, Jul 16, 2024 at 10:39:27PM -0400, Frank Li wrote:
> On Sat, Jun 08, 2024 at 05:16:31PM +0300, Laurent Pinchart wrote:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the chip by modelling it as an MFD device, with two
> > child devices for the GPIO and PWM functions.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 8059835bee19 ("MLK-25917-1 mfd: adp5585: add ADI adp5585 core
> > support") in their BSP kernel tree. It has been extensively rewritten.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Laurent:
> 	Just saw you already sent out adp5585 patches. Do you plan to
> continue work on this? If you are busy, I can help follow up this.

I just came back from vacation and have a large backlog. Please feel
free to take my v4, rebase it, address any review comments, and send a
v5 if you would like to help merging the driver faster. Please CC me on
the patch submission.

> > ---
> > Changes since v2:
> > 
> > - Add missing and remove extraneous headers
> > - Use i2c_get_match_data()
> > - Drop unneeded parentheses
> > - Use GENMASK()
> > - Drop of_match_ptr()
> > - Allow compilation on !OF with COMPILE_TEST
> > - Replace ADP5585_MAN_ID() macro with ADP5585_MAN_ID_MASK
> > - Drop unneeded macro
> > 
> > Changes since v1:
> > 
> > - Add comment to explain BANK and BIT macros
> > - Drop compatible strings from cells
> > - White space fixes
> > - Fix comparison to NULL
> > 
> > Changes compared to the NXP original version:
> > 
> > - Add MAINTAINERS entry
> > - Fix compatible strings for child devices
> > - Fix header guards
> > - Use lowercase hex constants
> > - White space fixes
> > - Use module_i2c_driver()
> > - Switch to regmap
> > - Drop I2C device ID table
> > - Drop ADP5585_REG_MASK
> > - Support R5 GPIO pin
> > - Drop dev field from adp5585_dev structure
> > - Check device ID at probe time
> > - Fix register field names
> > - Update copyright
> > - Update license to GPL-2.0-only
> > - Implement suspend/resume
> > ---
> >  MAINTAINERS                 |   2 +
> >  drivers/mfd/Kconfig         |  12 +++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/adp5585.c       | 199 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/adp5585.h | 126 +++++++++++++++++++++++
> >  5 files changed, 340 insertions(+)
> >  create mode 100644 drivers/mfd/adp5585.c
> >  create mode 100644 include/linux/mfd/adp5585.h

[snip]

-- 
Regards,

Laurent Pinchart


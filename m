Return-Path: <linux-pwm+bounces-2654-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6009239B3
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22A51F211E2
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18621534EB;
	Tue,  2 Jul 2024 09:21:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0813D8BA
	for <linux-pwm@vger.kernel.org>; Tue,  2 Jul 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912117; cv=none; b=SF0OXU1DI8QR881umozcaGs4KO99U3CSmbkibJEfL5C5VIbobXWD4Q8TgSUiKldCUl67uBII0bDV3VSosQOXiTp1gWYIu3i2mVBuSfrMNg5pzhNTRd0IV7nWhfaVB/0o0r39oQma3w8Z4dcySdbT2618r0C+mWq8F6Lk/y4QtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912117; c=relaxed/simple;
	bh=/+czjBljI3wS9Kh2OGhUIHaV5OrxeNvmtsSRi7Z2Kj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=scRHRVF/kHRe5fuerzv6/pAyziGBShaS1bv232GSuABN4s12Cm88q93e2BCNhjyj7lIWbX5PYRf0iXhHMtXtfhZixWgMZydpfrBKCOGWsN1VHB3SkuDz2xGS5uh68j2XEaDRbvZ6E3Uf+r1fBnqQ0hfzBMQnbpYtsZl9p59/rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZhv-0005CB-Dy; Tue, 02 Jul 2024 11:21:51 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZht-006ZnY-64; Tue, 02 Jul 2024 11:21:49 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZht-000426-0T;
	Tue, 02 Jul 2024 11:21:49 +0200
Message-ID: <0e5f6a7652e9813f638b16314ad1ac9a6059ac8f.camel@pengutronix.de>
Subject: Re: [PATCH v13] pwm: opencores: Add PWM driver support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>,
 linux-kernel@vger.kernel.org,  linux-pwm@vger.kernel.org
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Hal Feng
	 <hal.feng@starfivetech.com>
Date: Tue, 02 Jul 2024 11:21:49 +0200
In-Reply-To: <20240702083848.1947449-1-william.qiu@starfivetech.com>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

On Di, 2024-07-02 at 16:38 +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 239 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 259 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c4fdf74a3f9..3b547ede2ce5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16824,6 +16824,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
> =20
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1dd7921194f5..42158bc1c8bc 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -440,6 +440,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
> =20
> +config PWM_OCORES
> +	tristate "OpenCores PTC PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER

The reset controller API has stubs in case RESET_CONTROLLER is
disabled, so in general reset consumers don't need to depend on it.

regards
Philipp


Return-Path: <linux-pwm+bounces-5212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64FA664F1
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 02:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A17179A47
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819647081F;
	Tue, 18 Mar 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bsNvKS6Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580F5695;
	Tue, 18 Mar 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261111; cv=none; b=E4TelS/r3qu6Mb7ijrB+sH24N4fyWYaL3Cq4s57k2LUmS+9G80U8aHy7FDJA6J2S6i5CgzqN5YGn4L7bL29Xq3rA1SPOq1lgGSm90K3MCUpv6YBFcUxc1XgKGbsF5ubT60bNX7GI9HW1b5L4Nqw/Y2HcQq5nx4mn9JTZ0Pn+zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261111; c=relaxed/simple;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jtRCSaqHsT1jYcaG0GNozcqvHA9YThOMQdh+AloZ6sXfozKHsBKN6s/nRO/wWeAPhVEe4QB71ZY3kJJKXmh4zLmPjIHBbX//n4IKf4blmDTXzMDdo+Pb4EldM2WCi/+Y8ljTiEFsDfbGWy6gultH9Er+HhENnTXg6a2WZa+Mrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bsNvKS6Q; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261107;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bsNvKS6QD1044iBQatImnxqfM2ryIpayU6Xlej8mBkjEwgHgFdo+R6oFz2U3tP30t
	 Bcq37i1W6QRUC4qYCJqm3SVWHFzrXv/q5burE+CtCXaD0oILvyJgA4DT3mg9z8cIXB
	 Ejdt6SDdKdHeh7JkehZp/FtXZ5lW4CerqNRvXKCAGH1xXj0xZxL3rAMDwzcpkzM0Zm
	 mlCY8Y4FL66Rc9H0ydXLFPJG72PZvR80ZZoTsVMLdgckIU379emKNfAmY5lqhx5FNP
	 ZFgHLFwUS4MzKEKwVBIIeo839By+lfegH9Fx0XXzh6H9zhlTd6zl70ujcF5lCfVrwn
	 ESvNiLxQitVcg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DA1937A5D1;
	Tue, 18 Mar 2025 09:25:06 +0800 (AWST)
Message-ID: <bbc06c8cfd3ccd1847ec309f0fe4af80649720d4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 13/15] gpio: aspeed: use new line value setter callbacks
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, Michael Hennerich
 <michael.hennerich@analog.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Mun Yew Tham <mun.yew.tham@intel.com>,
 Joel Stanley <joel@jms.id.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 18 Mar 2025 11:55:06 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-13-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-13-1d5cceeebf8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-03 at 14:18 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


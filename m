Return-Path: <linux-pwm+bounces-5213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DDA664F7
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C39179C2A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B28248C;
	Tue, 18 Mar 2025 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="C+NGQUgu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB365695;
	Tue, 18 Mar 2025 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261201; cv=none; b=T6VYF7tpk8xQ4jjmmAeFK8wHD8krevVVYBq4QQfcgkJitPV9l0GxzS6YATShSK3qHcJemXsIqYxGjIUIwvRUxVcZO3Iu43YRfq8xAG8qONBx8cgSkN3R9sMv13NYxJOvsgeKs5KEy4i7aWYWkld9iYtUNQtIKwCMnClZC7H/p3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261201; c=relaxed/simple;
	bh=8qKvfbybSgzxVC9QLPwnRVKlfys38kBlYo29Mi3CfoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpAS9LGC25c+yRJcXWXXpy4fphRRCvnreYM2uj1b//ShwjurR+8WiT0BG1PG7FUaYdp4mTzeLsGDtGjQPy4k0hGMlGmjnw4b8S5kNQk7w8bZiFNbT8m5bszoqaavlW4dEG5lqrmh8QYldIg+pOH3nGgIgKN7fFL9qraJkz47cpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C+NGQUgu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261198;
	bh=8qKvfbybSgzxVC9QLPwnRVKlfys38kBlYo29Mi3CfoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C+NGQUgudkaryNlxpr+Bh9rYvk2OfGEBFs9x7fJ2Q1bAnXm9xqsV60gCn1kJVjx8r
	 7UWvgJxoo9f+Xas+7ze2zyTisPdjRvt6v+tyvEBxQo8432S2UhwskhE77CAfXjzhYh
	 NJAeFE4CsA3JGGjnriSHv6fW0fAZerqwjUzFfigHB81o+fq3Tbha3IWgEaAfV54MwR
	 YzgoSJnCuq2BMgIvrT/xetkcK1/rFhAKLXCrX3q68/9a8WN05p/HmxO4NOMnEIz7gi
	 90sFG6miV+Bm5HK1y1SxvCXjLaPy2ywC7atf/aY1fOTy+H5p1TE8aykGCQS7bnFdgX
	 Rm+VpKU4VqdUw==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C0D7F7A5D4;
	Tue, 18 Mar 2025 09:26:37 +0800 (AWST)
Message-ID: <ace3d4bfa8bf4d59e1578a5f8b7c9aa92a25d85b.camel@codeconstruct.com.au>
Subject: Re: [PATCH 14/15] gpio: aspeed-sgpio: use lock guards
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
Date: Tue, 18 Mar 2025 11:56:37 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-14-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-14-1d5cceeebf8b@linaro.org>
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
> Reduce the code complexity by using automatic lock guards with the raw
> spinlock.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


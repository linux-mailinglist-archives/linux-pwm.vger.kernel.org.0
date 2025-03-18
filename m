Return-Path: <linux-pwm+bounces-5211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B333CA664ED
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B410D189C3E6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1146426;
	Tue, 18 Mar 2025 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gKheE7nk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6C54782;
	Tue, 18 Mar 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261058; cv=none; b=NUgGpWB4RIMV2gStc3MP0oCDnfFFDdz9C+tztA2IUo9lu7dH6uJArAhfddPX0XJir+XjNTEY2qiVKRVfMFoTOzu4WIxH38X556kaAZ7JI6Mf7Coks8uXCZbE4UUTkN/qySqAI+PFcV2vikgcWBl4DaHwBHCpkdT4UIOUg4VvXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261058; c=relaxed/simple;
	bh=oMfWmktpO5zxS6QrUvvJTFoOQx0wf0RVH1WYkmIBE4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq//G73VTXQ2XJ7XrQRpLrcH/MGgq5HTcfSU+xvDYrd1WekcqQ0BGjHTJOzgEJC+nAiMA8LImvu7MB0X3Tx2uKIut8wgw5eIuNON89FuO3lysCPiVyXsGY0Qk2gGqmXctfHmemtuE6QK3VX7irwItxeBO1nlaagfdzIsCubFmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gKheE7nk; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261053;
	bh=oMfWmktpO5zxS6QrUvvJTFoOQx0wf0RVH1WYkmIBE4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gKheE7nkHHrYa81pj3sE05H0URAhJNVuDUirz7G+9ICCPCdhtph4aZJ+bosokKi9Z
	 38BoVsdQHhZzBwsuoD3MmJVFlRD71cHhnX8Z3fZaxstOgEAxirPoTYLT8i+QhNkQhW
	 Yyf5WgsJKVSSbGUpL9GeZPjaMe7Xe8TrPjTA0FBZ+hVOID0SFAO8u9LVfyNjCtolxU
	 Wqh6CFADRYZ8JuSzLRdCr+1/T2+4OA9uTPzoqnthTDjC6SSMIzyFULEh2QFl7tCSZf
	 4rFBtF7O3ycxB7HYVwuAY1DSDAiD7LZj1vueJJhp5GxMtJnA68E3yJrIDZlPJocf9A
	 /3R40MSPiHQ4Q==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6291777BB4;
	Tue, 18 Mar 2025 09:24:10 +0800 (AWST)
Message-ID: <2cf6056212d0eaae0946fd374edce1947afed93f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 12/15] gpio: aspeed: use lock guards
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
Date: Tue, 18 Mar 2025 11:54:10 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
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

Nice!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


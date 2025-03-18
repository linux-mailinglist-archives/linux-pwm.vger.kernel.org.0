Return-Path: <linux-pwm+bounces-5214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C0A664FC
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 02:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A88D179C2A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F858248C;
	Tue, 18 Mar 2025 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MQWYmk8T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1F5695;
	Tue, 18 Mar 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261258; cv=none; b=o8RFo3QmXpnrwkbKXYVii+UX09D/ElqFjutp4KG9uJIBOCJ/sbrQJ/jXoGyy2+MpYpi8dclCpCNkM4BbOEkJAmVplo1yVS6DGQS8wr0Pj2fRx/RPZwUqFYIHpRepLFXVjTLpf5cI5eJJjC5Z25fylfdW6qIfbz9ZPjWszzYUj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261258; c=relaxed/simple;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FURlElQ51nMPZ2SDINUADop+gutE6wRqlXfycX/iNyU8lZ5mTbKbgd3HTf1JpDll3vhNoXhTDvzmaF51sZmnTIGuDHuaHw7GiW+BbOMCLLbnshflRWVNeBN/tEg0YyvspQUq8zQPF1a2etxXvSYW1OQHuzIs34q4NZPgWfhmFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MQWYmk8T; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261254;
	bh=lPmp4bTaoMgGyxKWDl4hyootOO3DyrJbTpPjEsI959o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MQWYmk8TcQXao5iPuOHm2Zq43lqT1nc6k8aJyHOAOo+sXf9VN+kI/vmVrUw5RSa7d
	 KvsGQu8yN7QRfG1FxY95hlna5/EgKwrNLPKgsTWoNkTjz8qwafWIR8ezrvstFUE60J
	 aLR0rKR5FTbQ2K/k3bjTOCkbxAgEOum5VzvjFppbmGxmf7BCRwXLGSpFhB64KsZejS
	 X8ftTyvDt8mtHEHAtjbEWInsnJwCJC9uWlhUWC0ML3u+wTjghbynsrEBkmqonjmMrB
	 bTvn0Epz445EkXjvyKYZDj/Bm+nKkJhL1c5vh6WyUl14Wrw6HidfYlpWzxOLfSdW66
	 2LEOz+VgXTp0Q==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9D1227A5D7;
	Tue, 18 Mar 2025 09:27:33 +0800 (AWST)
Message-ID: <91090eae4f8f4843139ba0a0baf9215965cd44d6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 15/15] gpio: aspeed-sgpio: use new line value setter
 callbacks
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
Date: Tue, 18 Mar 2025 11:57:33 +1030
In-Reply-To: <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
	 <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
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


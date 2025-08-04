Return-Path: <linux-pwm+bounces-6940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C038EB19DF4
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21DF1894E9C
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09EE24291E;
	Mon,  4 Aug 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nizeyTGx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30461917E3
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297377; cv=none; b=kfzSZZz/7wLayhWfFlTClDA8QRQ67ec4lvZIeFetm3ILWQs/g/thm2bLhHsZhL4YrLnvuKWx1IDKc/V9oWqiBDP0fQielgG1QUnPQUtqQMPVzlB9kW9mJVnjIt/BZl/KRWWTEFYEu1bkfAnBwWSOeraKlTNPi0RTnjzvlHfdO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297377; c=relaxed/simple;
	bh=v9lomfM7rbZjRE8grQ/cTNg/PFAYWz1Hl/I0KQp90wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATzp5RZvM7RnkfaGUACCUxTzUh1YG1SMIUl0vt2LPfN9c3Gl+X1qkl+gNMvJ4igsVJmXQQJD1/uf6Kwmu2YfC4S1llp8qkfNrR6kzBqIMykjMKCXVS8OUj2AR1KhbNCKOdXQ0RG5mNizoZ8z5/UB/BAphEbdhqlLx6RgVyxcM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nizeyTGx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297374;
	bh=v9lomfM7rbZjRE8grQ/cTNg/PFAYWz1Hl/I0KQp90wM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nizeyTGxFerOSNofcf6J2JzRD6zmQIg0IE1yFArqpJvFVFsQOzmVzb/nWbep/qnRs
	 ls0QMiUMmIX/9bJJhRy8IUD0ibqJ3VJ5nfx7PyejeuZkJ7SiO1GC0Fcrrq7K5UaKTz
	 /Fic1IyANDXU1LttGRe6CWAdBZ5HfYM2A3kzfWUSjVNO+dIDPlHWHSMs1U9f6y6UYz
	 gYKfheWv7ZsyP0XN/oTTMOLi2Aiuq0HFGjWAsqU6gNHEexiH/kQafUo9VS7FLQFfmv
	 hxjeB9kF7vW4o4KiM8fiEzSIrfm9y4fempXMuErvloTXKsbwfPVlLcSZkFa494E0Sv
	 FVwg/Ry7GaVxQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA0F917E1110;
	Mon,  4 Aug 2025 10:49:33 +0200 (CEST)
Message-ID: <8508db81-eea3-4d2f-96d5-e669edd6a25e@collabora.com>
Date: Mon, 4 Aug 2025 10:49:33 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] pwm: mediatek: Initialize clks when the hardware
 is enabled at probe time
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-14-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-14-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> When a PWM is already configured by the bootloader (e.g. to power a
> backlight), the clk enable count must be increased to keep clock usage
> balanced. So check which PWMs are enabled during probe and enable the
> respective clocks.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




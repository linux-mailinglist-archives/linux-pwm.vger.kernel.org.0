Return-Path: <linux-pwm+bounces-1061-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1583C479
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E393F1C23A43
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5663415;
	Thu, 25 Jan 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MS/F7D5z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A78633ED
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192042; cv=none; b=WaJj8g1U8ZwzXVv/4ZYfiiuKjUxqAJRGipS1v1ePnQcsRGatqbUMncrwVJaE2kDZN+SCmgDRZFdiMLQ1mLcVnjEJfmaKbRTTfHYZP6a47ZuwT9A2ZPvveaMQsed/5aSJlJjbwuF26eeh2S8nzeXDyEMkVaYamc3ztRd3gg9wQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192042; c=relaxed/simple;
	bh=jKQrE4Opvi83GnSvOecQn5WCn3KGRH8+nQTk7o5aKuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI13V1tQoigpKlHq/PqlF51oJq7Zydi+eenF9ef+5Q6ucWRV5Ron0Npd++kArVOWMg6IpITjEvIQf/xJ89Pyoz3LywStiJ3OK8Po57NlZo2gUsOrdHS425mR6knUj9lIJrpjbmlkxcuGww2+NjaO8FLwBDcQEKZovLG0aPhDrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MS/F7D5z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706192033;
	bh=jKQrE4Opvi83GnSvOecQn5WCn3KGRH8+nQTk7o5aKuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MS/F7D5z1wGut6xcl6AhDbGSLg4Xyc9AdVdHrix76OrCInF2IVsT3/yauIfPWiZ2G
	 GO3Q5ZeihHPA/AJob9mXVQt+p5jx9vQYIODGvlzPJuIQ7g78bDJbJ+dxhquXdsQcp6
	 cahN4yEQ6Mvud8bIJigYlbzAHTYgqEGwOsybenHP9RJnIxRRQd18M8oYw1YKKwcxOW
	 aEIa2FsgqxltrftmKYVBghnbdtXxLsV61hkV5yswhPpY2Njm9GkZGGXm/vFpndGq0d
	 4EhDSlrU+K19s+OOq2G/sEWAQyEZAQsfi4vJnnYOFEkOBOpiQ/eDufILcWfdEivEGK
	 QTZIlkp2pUxMA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E1F737820C0;
	Thu, 25 Jan 2024 14:13:53 +0000 (UTC)
Message-ID: <1c9b0338-a095-467a-9b2d-4e152eed6e74@collabora.com>
Date: Thu, 25 Jan 2024 15:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 020/111] pwm: mtk-disp: Make use of pwmchip_parent()
 macro
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <0ebb99812e0d563437d2cdb8d980e89461e28a6d.1706182805.git.u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0ebb99812e0d563437d2cdb8d980e89461e28a6d.1706182805.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/01/24 13:08, Uwe Kleine-König ha scritto:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



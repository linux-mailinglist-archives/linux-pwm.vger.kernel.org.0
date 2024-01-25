Return-Path: <linux-pwm+bounces-1059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C418C83C472
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017FD1C210B7
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD09633FB;
	Thu, 25 Jan 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IKDpBg9n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D667633ED
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192039; cv=none; b=WwRisYYOlViY5wawJmXoYPVZlZLU9G9D7pgaoUIx9TM6yMgVuJIu4DUs3bV3g143YaI+oNCgEjJ4K1chRgV4X+pR2e0fJ8pqA02s/jlKHSg7eLK/htqovNhZH4bfd5dmFOh3dpYaFbzF5MnaA6AyN1kvX56pd2G2CSCh/MR1ToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192039; c=relaxed/simple;
	bh=/HdxlFWEigL3KWcoKYFXx+46bfXTbqJ9I/9en4fDMnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQ8p/sN+4Mn+TJYuJZ+9Y1RlReb0E2M69GaX7JR48zNFTf5k8dNJhhB7hRsIFC5vL/1YrojqCFImy0YiX6HmWPQnPJ35+a+XA/uSbKGqhtbIKo03hF3ACT/ke5Jl64EdBaUHmM9dRNgtfHcdC6AsNRj+TdFO21R4sHQIkhwIaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IKDpBg9n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706192030;
	bh=/HdxlFWEigL3KWcoKYFXx+46bfXTbqJ9I/9en4fDMnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IKDpBg9njiry3orddbTQbxj8sqPQB/IdvbtvjxTSJXSwYu+x3sXj5KAu5QUVWJQ4j
	 dXzIiAaBmdpPvA8yA14ver033kXCe3lMdbdbz/3Xk91j/H4fsU52T5+D37yjs2yXRX
	 lX2XWVsVVlfsCKB9Abt3RJShr4a0Aw6gZ5Qq/31ZCvRb/prZkZuqGDc7FuOQe+9dnY
	 ucC+g8DcXFrNSUy9u2ag5RYd2iKMsOrLvojupTc3gmz8FQhACs6b2OqkDb7dmvCl7z
	 MSSVXnmNL33PkKyWDTFMt5WI0p+1DvsDTRH0jWvJzrknI680N7Sk3ZP5rCNewqh+C6
	 s0b1zT4xkbpcA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12BAC3782057;
	Thu, 25 Jan 2024 14:13:50 +0000 (UTC)
Message-ID: <d0a456b3-744d-4e58-bbcb-e939117376f5@collabora.com>
Date: Thu, 25 Jan 2024 15:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 074/111] pwm: mtk-disp: Make use of
 devm_pwmchip_alloc() function
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <77d027ef065580f5f29fc003bb0cad6bda1abdb1.1706182805.git.u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <77d027ef065580f5f29fc003bb0cad6bda1abdb1.1706182805.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/01/24 13:09, Uwe Kleine-König ha scritto:
> This prepares the pwm-mtk-disp driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




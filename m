Return-Path: <linux-pwm+bounces-6941-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DB0B19DF6
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BB37A6C13
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA576243399;
	Mon,  4 Aug 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eWKxayx+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03909242D89
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297380; cv=none; b=bp0HLY6FetphDaWNFF8byMSKKQSprZxM0V4VCRDuy5yctTycGXtQEbLR+WR9FcjhiuHUUpFJpSjx/oOzMdJn8LBWyXfvbnWD0TOhh/rgOc/XAJpGFtNFcp6f5ozv4nbqvPqfNrXjxtT8MLfS1kQm5ys2uq07xEQOAFcyt+jxgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297380; c=relaxed/simple;
	bh=nXkeDIP7ZV/N4coPJgNQkt15fEwvTffRHGCDXbFcPYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1kuiunllG2YLPPOWU9mswJd2Q9+4SHegRp6Thun+p+XN2onf6xH/IcJHzyFyJSl1rL/R7pPPaGwRuYZm+4Iki897zVy9dIQJxTHYLQsfYgU/B6rDVBAL6gf2ky62qWGZkX7MByzlZb072fgEbRjrvk7bN0yYrbwnK+VB/h1LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eWKxayx+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297377;
	bh=nXkeDIP7ZV/N4coPJgNQkt15fEwvTffRHGCDXbFcPYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eWKxayx+aet4gpAcun29UOprDRBTBFLW5jmDx2U+nxPRWF+Mn3n0YJIB97hjtoTmI
	 qPxujPoYGZ15Gx8ywyRGXdfeLabHbp6s1uQUunMGWma7MT3tTZbmpGOcbBwsMuxdaE
	 iUGff76XXc9IX5Wnylc49m7C2i4hNTlu143eTl51hEnbSeQMjmQnUJuXLgG6swjGau
	 /oKOYzEwusmIkLa4N3MDz3aT3Ias+0P2hCowIxjEfjDHz2UTbyjKTH4RisCdv9cbc9
	 xjcyTSbls3yISLG69UoLfyi4gXOMqVDm+maMfDE4bTEdS+/Z9+Nr9OJfEV2lhyumM3
	 F5P5tgVeF2Iiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EE3A17E048E;
	Mon,  4 Aug 2025 10:49:37 +0200 (CEST)
Message-ID: <b32e561c-4587-4bdc-b108-2ceb342d3e37@collabora.com>
Date: Mon, 4 Aug 2025 10:49:36 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] pwm: mediatek: Fix various issues in the .apply()
 callback
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-16-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-16-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> duty_cycle and period were silently cast from u64 to int losing
> relevant bits. Dividing by the result of a division (resolution) looses
> precision. clkdiv was determined using a loop while it can be done
> without one. Also too low period values were not catched.
> 
> Improve all these issues. Handling period and duty_cycle being u64 now
> requires a bit more care to prevent overflows, so mul_u64_u64_div_u64()
> is used.
> 
> The changes implemented in this change also align the chosen hardware
> settings to match the usual PWM rules (i.e. round down instead round
> nearest) and so .apply() also matches .get_state() silencing several
> warnings with PWM_DEBUG=y. While this probably doesn't result in
> problems, this aspect makes this change---though it might be considered
> a fix---unsuitable for backporting.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




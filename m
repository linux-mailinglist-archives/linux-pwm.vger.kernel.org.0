Return-Path: <linux-pwm+bounces-6945-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800AB19DFA
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D11518994C2
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA51F4634;
	Mon,  4 Aug 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cis9BLS7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64623BD13
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297405; cv=none; b=BQV+51KJgUHZMODKUodOd6+ifMDle5EEZsV8Rf2haWiKDto7/rh66BanxLHYgIntYyzV35drDeOWcGMjobD/9XF4B9nUWmo/WU05XzjcZZzl6ITeKvqtIM1iV50MS952vfe/u2tNdM0DjnTkQ5sE02YuMQB4p88EEk6rJEN8ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297405; c=relaxed/simple;
	bh=O7gwINFF5JtvjcF8qGuf6WqNIWL34MoiePTtqmNDuzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgcHcAoRRVv+hKdpam7k8M0tIOigNMY1doPrrVfChKlRLNshnFcA1L5aXSxCld8UBAOfTQRtj2yNw6XoyOAZgS/wKCruXlCGvraaODhKd7KCoENheAsyWs2SuKKBEoF/N7M8SE71A3J7Zv62vQA+ICaz7CR2w+9wMHoSeOgUFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cis9BLS7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297401;
	bh=O7gwINFF5JtvjcF8qGuf6WqNIWL34MoiePTtqmNDuzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cis9BLS7lAOWOYGwO45aiv7jtrV5JEhGMZQdVeargNQX+HL245tLkcmdCkn2qTxYq
	 C4mrvZ7/W1usAmZqIKTglUyX6ZShpGx3rzcH0Jsr2S2wd2oXfJpftv2RSIJh6hjxjL
	 ZOgQS13piqU9KLReCHD6etaYKKxmfqy2snuUHaqTMtV67ANDx8IfA8cIirHPDmpk2w
	 YHFodujLYERMN4OqRTTHtToVoxaG2DaVTdBxEJTUzK4B9iKqrR3GZsu/3rNs6s3Gq0
	 jND07F5aNWQ6Yd2P4qAGtBwWzn5Cu7Cu9J9mlmPvJwl0bPhD7YfosvwR+2gDXrTiC2
	 g2NDY5EQJYL2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F75717E0DB9;
	Mon,  4 Aug 2025 10:50:01 +0200 (CEST)
Message-ID: <e3495f99-4a78-4910-9b67-6c25dfe7f989@collabora.com>
Date: Mon, 4 Aug 2025 10:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> The general register layout contains some per-chip registers starting at
> offset 0 and then at a higher address there are n nearly identical and
> equidistant blocks for the registers of the n channels.
> 
> This allows to represent the offsets of per-channel registers as $base +
> i * $width instead of listing all (or too many) offsets explicitly in an
> array. So for a small additional effort in pwm_mediatek_writel() the
> three arrays with the channel offsets can be dropped.
> 
> The size changes according to bloat-o-meter are:
> 
> 	add/remove: 0/3 grow/shrink: 1/0 up/down: 12/-96 (-84)
> 	Function                                     old     new   delta
> 	pwm_mediatek_apply                           696     708     +12
> 	mtk_pwm_reg_offset_v3                         32       -     -32
> 	mtk_pwm_reg_offset_v2                         32       -     -32
> 	mtk_pwm_reg_offset_v1                         32       -     -32
> 	Total: Before=5347, After=5263, chg -1.57%
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

What if we do, instead...

struct pwm_mediatek_regs {
	u16 pwm_ck_26m_sel_reg;
	u16 chan_base;
	u16 chan_width;
};

struct pwm_mediatek_regs pwm_v1_reg_data = {
	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
	.chan_base = 0x10,
	.chan_width = 0x40,
};

static const struct pwm_mediatek_of_data mt7986_pwm_data = {
	....
	.reg_data = &pwm_v1_reg_data,
};

...that should reduce the bloat even more :-)

Cheers,
Angelo

> ---
>   drivers/pwm/pwm-mediatek.c | 58 ++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 4460bbca2582..4dfe657957bf 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -38,7 +38,8 @@ struct pwm_mediatek_of_data {
>   	unsigned int num_pwms;
>   	bool pwm45_fixup;
>   	u16 pwm_ck_26m_sel_reg;
> -	const unsigned int *reg_offset;
> +	unsigned int chanreg_base;
> +	unsigned int chanreg_width;
>   };
>   
>   /**
> @@ -57,19 +58,6 @@ struct pwm_mediatek_chip {
>   	const struct pwm_mediatek_of_data *soc;
>   };
>   
> -static const unsigned int mtk_pwm_reg_offset_v1[] = {
> -	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
> -};
> -
> -static const unsigned int mtk_pwm_reg_offset_v2[] = {
> -	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
> -};
> -
> -/* PWM IP Version 3.0.2 */
> -static const unsigned int mtk_pwm_reg_offset_v3[] = {
> -	0x0100, 0x0200, 0x0300, 0x0400, 0x0500, 0x0600, 0x0700, 0x0800
> -};
> -
>   static inline struct pwm_mediatek_chip *
>   to_pwm_mediatek_chip(struct pwm_chip *chip)
>   {
> @@ -118,7 +106,8 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
>   				       unsigned int num, unsigned int offset,
>   				       u32 value)
>   {
> -	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
> +	writel(value, chip->regs + chip->soc->chanreg_base +
> +	       num * chip->soc->chanreg_width + offset);
>   }
>   
>   static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -306,86 +295,99 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
>   static const struct pwm_mediatek_of_data mt2712_pwm_data = {
>   	.num_pwms = 8,
>   	.pwm45_fixup = false,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt6795_pwm_data = {
>   	.num_pwms = 7,
>   	.pwm45_fixup = false,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7622_pwm_data = {
>   	.num_pwms = 6,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7623_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = true,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7628_pwm_data = {
>   	.num_pwms = 4,
>   	.pwm45_fixup = true,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7629_pwm_data = {
>   	.num_pwms = 1,
>   	.pwm45_fixup = false,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7981_pwm_data = {
>   	.num_pwms = 3,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v2,
> +	.chanreg_base = 0x80,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7986_pwm_data = {
>   	.num_pwms = 2,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt7988_pwm_data = {
>   	.num_pwms = 8,
>   	.pwm45_fixup = false,
> -	.reg_offset = mtk_pwm_reg_offset_v2,
> +	.chanreg_base = 0x80,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt8183_pwm_data = {
>   	.num_pwms = 4,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt8365_pwm_data = {
>   	.num_pwms = 3,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt8516_pwm_data = {
>   	.num_pwms = 5,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
> -	.reg_offset = mtk_pwm_reg_offset_v1,
> +	.chanreg_base = 0x10,
> +	.chanreg_width = 0x40,
>   };
>   
>   static const struct pwm_mediatek_of_data mt6991_pwm_data = {
>   	.num_pwms = 4,
>   	.pwm45_fixup = false,
>   	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL_V3,
> -	.reg_offset = mtk_pwm_reg_offset_v3,
> +	.chanreg_base = 0x100,
> +	.chanreg_width = 0x100,
>   };
>   
>   static const struct of_device_id pwm_mediatek_of_match[] = {




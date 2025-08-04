Return-Path: <linux-pwm+bounces-6953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9647EB1A33A
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A4B3A527B
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7E265CBE;
	Mon,  4 Aug 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FsGI8R9A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D2236A9F
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314147; cv=none; b=gVLr3jttEENX7SEZaNI/ZvmD7h2lt+On+0IfAaiHn5EDgoCqTPHz8nglaoaosmtJCzxkOnyRRJH5gX5NSl/56QajTAKvKljvoVhobRjHgcwrl6lddBmelVYePxJAEBPQJdY8rrNhraKT2MvQxsRomC1cYyo0Lzwdz2wiHqqEJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314147; c=relaxed/simple;
	bh=SCG+LNNTP4RLqJeIN4GK6dNLDFBXxFKtHidyNocRs9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmipZP08GUc96RYp/L2QuebEDSogcVEFWOZI5AnISCGrLYddZWVi8Lku8c0MAqOImdND+gDdFOR0uCn89/ZoQOo1IJPndrkXuOcBLRuBE4dB5CICV7uqRtqNhR0lK6mKhQi6ib59P55WOH28UmExmI+Ah/d3pqWiSGlQ0v2RQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FsGI8R9A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314143;
	bh=SCG+LNNTP4RLqJeIN4GK6dNLDFBXxFKtHidyNocRs9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FsGI8R9AvwpW7O5KwsSfonK4ZR7OEIcQ4q6VggvyeZn2WjZ/EHkOss8eqAsZpYmvd
	 ij9IXo+aFJEduRzP3y9GezvpsxMZN4i13+E/nHGIVqyy0txxG3RAF/9FudmHiZoY+l
	 s8ZHLn0V8TBK+ayJFgCV34bFKp3axDdkltHFXOlwkIYuMUAmVbCBLiCYupirk5+zFZ
	 SD6+TO4wDdSkAoYy+cy3P0xXpvpzv18hBSBtEwBZTUgIgKwYP9oDzwrufxr/rSX5gI
	 FXZWfX8PWPsi/1znkOGD44+2X8Qw+fhxzEgGcXz/GUzD9QmaAb5aEH28CsCFW8tnBF
	 kR7mWJX4Zg4gQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97F1917E0202;
	Mon,  4 Aug 2025 15:29:03 +0200 (CEST)
Message-ID: <fe2e5620-06de-4782-b7e5-c6d3ba50a95c@collabora.com>
Date: Mon, 4 Aug 2025 15:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
 <e3495f99-4a78-4910-9b67-6c25dfe7f989@collabora.com>
 <g4qrehzi44mgvmy76wnrhabmin454wwrngubvvikgjv3w5udl7@wmxrly3mxoiu>
 <fpgfnzx57qzr5jxfl7g7kwtjodw5pvpjz3z42fft5p6rtyzbro@hjgavja6numh>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <fpgfnzx57qzr5jxfl7g7kwtjodw5pvpjz3z42fft5p6rtyzbro@hjgavja6numh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/08/25 15:14, Uwe Kleine-König ha scritto:
> On Mon, Aug 04, 2025 at 12:30:45PM +0200, Uwe Kleine-König wrote:
>> Hallo AngeloGioacchino,
>>
>> On Mon, Aug 04, 2025 at 10:50:01AM +0200, AngeloGioacchino Del Regno wrote:
>>> Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
>>>> The general register layout contains some per-chip registers starting at
>>>> offset 0 and then at a higher address there are n nearly identical and
>>>> equidistant blocks for the registers of the n channels.
>>>>
>>>> This allows to represent the offsets of per-channel registers as $base +
>>>> i * $width instead of listing all (or too many) offsets explicitly in an
>>>> array. So for a small additional effort in pwm_mediatek_writel() the
>>>> three arrays with the channel offsets can be dropped.
>>>>
>>>> The size changes according to bloat-o-meter are:
>>>>
>>>> 	add/remove: 0/3 grow/shrink: 1/0 up/down: 12/-96 (-84)
>>>> 	Function                                     old     new   delta
>>>> 	pwm_mediatek_apply                           696     708     +12
>>>> 	mtk_pwm_reg_offset_v3                         32       -     -32
>>>> 	mtk_pwm_reg_offset_v2                         32       -     -32
>>>> 	mtk_pwm_reg_offset_v1                         32       -     -32
>>>> 	Total: Before=5347, After=5263, chg -1.57%
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>>
>>> What if we do, instead...
>>>
>>> struct pwm_mediatek_regs {
>>> 	u16 pwm_ck_26m_sel_reg;
>>> 	u16 chan_base;
>>> 	u16 chan_width;
>>> };
>>>
>>> struct pwm_mediatek_regs pwm_v1_reg_data = {
>>> 	.pwm_ck_26m_sel_reg = PWM_CK_26M_SEL,
>>> 	.chan_base = 0x10,
>>> 	.chan_width = 0x40,
>>> };
>>>
>>> static const struct pwm_mediatek_of_data mt7986_pwm_data = {
>>> 	....
>>> 	.reg_data = &pwm_v1_reg_data,
>>> };
>>>
>>> ...that should reduce the bloat even more :-)
>>
>> Having the three u16 directly in pwm_mediatek_of_data is cheaper because
>> .reg_data is a pointer and so 64 bits wide (on arm64) and so bigger than
>> 3xu16. Also having the data directly in pwm_mediatek_of_data saves one
>> indirection and so it should also be slightly faster.
> 
> I took the time to complete your patch suggestion and the bloat-o-meter
> output is:
> 
> add/remove: 4/3 grow/shrink: 1/0 up/down: 56/-96 (-40)
> Function                                     old     new   delta
> pwm_mediatek_apply                           776     808     +32
> pwm_mediatek_v3_26m_reg_data                   -       6      +6
> pwm_mediatek_v2_reg_data                       -       6      +6
> pwm_mediatek_v1_reg_data                       -       6      +6
> pwm_mediatek_v1_26m_reg_data                   -       6      +6
> mtk_pwm_reg_offset_v3                         32       -     -32
> mtk_pwm_reg_offset_v2                         32       -     -32
> mtk_pwm_reg_offset_v1                         32       -     -32
> Total: Before=5427, After=5387, chg -0.74%
> 
> See below for the complete patch for reference.
> 
> I tend to stick to my variant, also because then all info is in a single
> struct which is nice for both the human reader and the generated code
> (only on indirection).
> 

With this amount of reasoning, I can only say ...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

;-)

Cheers!
Angelo

> Best regards
> Uwe
> 


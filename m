Return-Path: <linux-pwm+bounces-6752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C9EAFAFC3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D3D3BCBB2
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B9261595;
	Mon,  7 Jul 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JQ6wodTv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC32188713
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880784; cv=none; b=DdXtktc0nuX7+hXJ3oqTOu2fryZmf/Gu0csez2BKlNN6e7HnU9h2+F1zh+diGv5xhzUZ9+UCv4+lTwQoxqdYRA3KbDiZdFDf6BeYFPR5RTP371G0PdJEPk7DIlW1GLoJM5/OvEJV4zKFGTEX3WE3u4+5ls3r3XzENaeyWvS/CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880784; c=relaxed/simple;
	bh=juc1uD8h40wIfZMQNmHnpyqExi3zRLlYO4TDODPHXFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGhjNwIkwV+kHTC8LbgPw9YLHS3E0mIG8OAk+G0rkipu29Y1uWDnBWNch1nVKaUKr26sgdJ8TNlflsvQeeVF+3PXlLsLYOwsR0mN+asTWTYpud0Xo7TwaubHkeERqziyFhbNJcLbVxNaqcLk2MKpuQp1IweXroJ5WfZ+CKG2YRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JQ6wodTv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751880781;
	bh=juc1uD8h40wIfZMQNmHnpyqExi3zRLlYO4TDODPHXFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JQ6wodTvDmy/b9DtS/pdAefE2yXpzXmVwxrlGUiRge8OY87qEoQ7eZHuUWmh/EFdU
	 9bjUgE7nkQ7UXMpu7LZ9RIcacg1Qt4o8yjdVmEdfO75d+vCjW6hpv+hA35xSGu2ey9
	 BXboBhWVaNN6xX9AxEqWRFw+h5uYAmOqK58g+NbqlLcunfHe3mgZVqBBtDZ4Uubtfm
	 WDoqmuSXXDBrbFQ6+2/AcR6CVJO1NSoZ/Wo6fuwpeqeAsOBbmJYJrpsZWMowepboZs
	 k2d/+TTNwBz1PYP+J01njEpwsZ8LDqvXVbzzFp4aTgpANs2Hoi+KI5GA9rth3w/SLd
	 5WHNCRsqhoQHw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9BE3E17E0630;
	Mon,  7 Jul 2025 11:33:00 +0200 (CEST)
Message-ID: <ad575b88-80c7-4301-96eb-b34d97c5d5fa@collabora.com>
Date: Mon, 7 Jul 2025 11:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/07/25 19:27, Uwe Kleine-König ha scritto:
> After enabling the clocks each error path must disable the clocks again.
> One of them failed to do so. Unify the error paths to use goto to make it
> harder for future changes to add a similar bug.
> 

I don't like gotos, but admittedly that's the cleanest option, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo


Return-Path: <linux-pwm+bounces-6939-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC3B19DF2
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414947A5876
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAFA239E79;
	Mon,  4 Aug 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hnUxh6WB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF52F30
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297376; cv=none; b=p6iTr9xtJNg3ZKl5tO/lBhUDCs5GRHHRPBEHhkV2Tm5q9/sCZpY3Wo5Y3vHba1yKe6b2zYAxCdVJgdYLNd5BeMg850LdNSAbM7JjTijae3k3Lqjcp9gdwC3cJ3P/P4urc/etPajsRwcU9z1gmTdQCvDS4ZFYmh80M8r4yKIaG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297376; c=relaxed/simple;
	bh=3qrX1jknYp4qOJKggBsAx8Iwi18RT/dYzgUfn0sqFr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1wghe0KkUdFNFds0j4IMDcVVZrnp9W92ksLPO4K3JatkK3jA/mOFoUQqZxMdPxZmHkt2PUf+hs76obdiP4VQOR4CPp/+9IAp3mx240cWhMitXbrsOJNq2KaE5/Pq8YSuPmRPXMUVnms7eJXYmVGhOn6u7RRDJ+3pmlhVWXvlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hnUxh6WB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297372;
	bh=3qrX1jknYp4qOJKggBsAx8Iwi18RT/dYzgUfn0sqFr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hnUxh6WBTaOpXfYFHlkV61oo8O6aw0KHmCGDH3VVACls9w0uVgRfRtpnMlYM3RD57
	 cnGWmgvJxNX5nAqOLNTkWHBvByEj11WlgfSriaZFxcMSeYzoxY9zJuKC9sx7sMzd/A
	 b9kCYNAzkusFQ03F1QnGXe3aIxDhkjiw9NZjWvHcMX5Xaswah+WEDUkBY7rYQKbVlj
	 3mtPbfwndY5KhDTZTKQPQNGypluMxB/YtOpgtQfP5H7ZPfLJQ/Lri5VgFUWNGcxhXj
	 c1AVh26T8p7zyUTcuTs8Pve4typc5Ege+rExN9rp2evHEdcENt60fQzP+D5TR8vIf3
	 XBKIEVy0Nnd8A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 67B4C17E04DA;
	Mon,  4 Aug 2025 10:49:32 +0200 (CEST)
Message-ID: <606f520a-9921-454c-9967-e545cbfa5a3b@collabora.com>
Date: Mon, 4 Aug 2025 10:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] pwm: mediatek: Lock and cache clock rate
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-17-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-17-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> This simplifies error handling and reduces the amount of clk_get_rate()
> calls.
> 
> While touching the clk handling also allocate the clock array as part of
> driver data and lock the clock rate to ensure that the output doesn't
> change unexpectedly.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




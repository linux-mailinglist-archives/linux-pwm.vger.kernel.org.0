Return-Path: <linux-pwm+bounces-6942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA95B19DF5
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCDC3BAAAB
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031424167F;
	Mon,  4 Aug 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gl5sO8ps"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2A243370
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297382; cv=none; b=AGthJphN6rXFac05GwCRUwh4b46DQ/gkSSijCWpFqWspjm4xaYWxHNSmBgJx/N9bePxJdF4YzXrSZHvYyZ/dp6EId6I0Jj4cW429QzySiSEvL+AV5d/23CL9FIutpgLxHIsyvagR36s21i9S0SU0qAMikpYuzW1LAKvuEVml+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297382; c=relaxed/simple;
	bh=uEPY2NMSqAK+CpEdpvsDmGeXQkYcRzHTYJ6NvWltjLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld7uLiNl7t/8FdBVCMgYIHECrLYvdGLSmg9ONMUprDHr8UfhKz/xJccEJMJ0sab/bc0DpF4UU7N54wmIU69ASEiUOCVF52nEiz3RIyObeKYVGNVBFYLiUT6vyGhQrmQ5YTGr7UCni4N0929ZRQ+FLp5BlDY4vGjU3rXre1xDIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gl5sO8ps; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297379;
	bh=uEPY2NMSqAK+CpEdpvsDmGeXQkYcRzHTYJ6NvWltjLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gl5sO8psb9LsdY8FYwWSXG35W8zf2MMs7VI3+Jv3GmDCA/+PIJY0pCizKmQHZnXS8
	 H7RIoHkiq8YMORSIHO/gStf3f834yywI/NsLAoDgT1ye212GqI/eNWjYFLGGgYypxp
	 r8Ysd5K8lBObzjQwQcpDccpVxegSTfdvYE1Qwc1Zrm4SDKzfnhjZwRKBBdKz/o0uAB
	 Gmrtg79ZB1iTM306zHXddO0rBfj8zChZ4j2HGidF6xIIGCJQWte0fWnqLUxZArRPUZ
	 A48VNKTutYAH6eTSFzy8JaC91+IQYASSCPpzv3FWPNvTi7GQ9q/Z+gj3iBG9IAEBkV
	 Opp88qX0mQ9zw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AFD0017E04DA;
	Mon,  4 Aug 2025 10:49:38 +0200 (CEST)
Message-ID: <958e731c-6c4b-45bd-ad9f-1860552c57c6@collabora.com>
Date: Mon, 4 Aug 2025 10:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] pwm: mediatek: Rework parameters for clk helper
 function
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-13-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-13-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> Convert pwm_mediatek_clk_enable() and pwm_mediatek_clk_disable() to take
> lower level parameters. This enables these functions to be used in the next
> commit when there is no valid pwm_chip and pwm_device yet.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




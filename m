Return-Path: <linux-pwm+bounces-1062-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735FA83C47C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153D2B21969
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D83633ED;
	Thu, 25 Jan 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="to9mna+z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083D633F8
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192043; cv=none; b=DocII/mzixRnWM2qRoaAEv4m1nxsrLWYIWWfZBmN35qCdUKg3TnPk/xgV7J9AXc4ZwftBKcda8IbG661saCH+rTQcoSkG6kLxeEZ6EL7+YR1LmesvjNlmsiKNA4FYdbjytnpJJpWHtTXZgSk6gN8OWRHEn3Wgv8eXN2Ik0oMxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192043; c=relaxed/simple;
	bh=jKQrE4Opvi83GnSvOecQn5WCn3KGRH8+nQTk7o5aKuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y04YsB64ITDtY6TTt4tGRG9gjpjVaiTfqxRrSMYeEr4TeN52knfWb5OyfIEHvCtXdXJV9+zsCgqCcgXE3IHorpQW671IaJpRzZ+vTaGEjCXRR0lJIA1yQaKV+wKY7iL/QAo9Fzf8eM+gxc52336elkJClMQa/02MiNtYFDomUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=to9mna+z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706192035;
	bh=jKQrE4Opvi83GnSvOecQn5WCn3KGRH8+nQTk7o5aKuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=to9mna+zvXObqkiyRx10HvrMZqUQ+JTuJkq/pM5EhFtnovXXxv/68nvOTzaxO3rxx
	 TifkAmhOkrmDn7pRbPPln9j4nynEeS0WB2zpLfayvkuNGTVMNbmt13JRaja7BtO/zT
	 YPf+NNEAACRfsC4WsCHDRw3+p0FRb6vaXKb2qL4nPopXlNxsECu/J+6vAlDcT4wQde
	 sPpjNalVUgl25G1TH91rxcJ/T7wirD/27CwLSyIo6OnRe7RqEMaxHvMhzqpczB5jb2
	 A8E4ev5gLptfmQowoKP3qGYY9egXStIWlEFweP39bEvNpU3UxfpaXFrFJrwnTkwKYj
	 iKNK/dceXzPoA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B9DE37820C2;
	Thu, 25 Jan 2024 14:13:54 +0000 (UTC)
Message-ID: <2277f739-e1d4-4ee3-87b5-43c0229d05f1@collabora.com>
Date: Thu, 25 Jan 2024 15:13:54 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 018/111] pwm: mediatek: Make use of pwmchip_parent()
 macro
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <a8659059ce62805d5a499edb823ace388f374d6c.1706182805.git.u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a8659059ce62805d5a499edb823ace388f374d6c.1706182805.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/01/24 13:08, Uwe Kleine-König ha scritto:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



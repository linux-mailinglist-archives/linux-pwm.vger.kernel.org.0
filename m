Return-Path: <linux-pwm+bounces-4353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A59F1FEF
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504871666CE
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41621990A2;
	Sat, 14 Dec 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIbYotUU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A21192B75;
	Sat, 14 Dec 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195375; cv=none; b=VYFRI2pbz6ig3E8j9msyHpdOQITeppAxVWI96ZwqYxCqZAnTX9RBAuR3+eUDdLDszj9eOljS7VJQn4rAXNPZ3siWB73gj3NGuAwT8ZiZw1e/Fxowh5+O1ZjiLl70iRT/KjDIl322mQsbMUIySRMsxJo/DYcMoTZxcfX0O72KOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195375; c=relaxed/simple;
	bh=078vonmjDPYa7cx+TCBvXwXah+/q/AgStB2Jmt8KH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pG1TwR+sSYMl/g696qpwyQjnq5u9XxZdyriGeXRekjePbbNHu5PmrBoQYVrLhGoPJzbaXUbxUJDaNqAf5GFPt9+p4eRtZSg2soM8XzVhtuZSx6l/VM2GjtJKehf+ygWnb3rbt+MkhM+niwtuRsRWROt/Oy727PXUfs7RB+Paqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIbYotUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA2C4CED1;
	Sat, 14 Dec 2024 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734195374;
	bh=078vonmjDPYa7cx+TCBvXwXah+/q/AgStB2Jmt8KH8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MIbYotUUFwVKEf2qYSM4mnNUDHfpZfczZiPVaYwn9VuJFd0AiuWspO6XuQLgoqLMa
	 nj1KwAAs+D/QDjW7EuP/zLNpuzTdEKdudNyMPIt9X+lJNDrXcRiHCeTUuT0zXGeHJn
	 8g1KXwKU7KsalWrTQuWxh1N9LvHKpCHDNXKxrDSuyKyavVi6IZH16D0vBjlZU7RfIU
	 HkDUjmQ9TMTNXvqeqzVorCh2GCoPBapV8oDY9AKynEzIrmEisa6HBW7zg7RPNCTjBP
	 S6q6swCoq7GUB3blD9s0Gd5PPsidkf0oIkTAdzpEN0McNYpfG1stDIOtEU9y2la6k8
	 wRdSrEGqGMKsQ==
Date: Sat, 14 Dec 2024 16:56:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 10/17] iio: adc: ad7944: don't use storagebits for
 sizing
Message-ID: <20241214165602.781da5db@jic23-huawei>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-10-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	<20241211-dlech-mainline-spi-engine-offload-2-v6-10-88ee574d5d03@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:54:47 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Replace use of storagebits with realbits for determining the number of
> bytes needed for SPI transfers.
> 
> When adding SPI offload support, storagebits will no longer be
> guaranteed to be the "best fit" for 16-bit chips so we can no longer
> rely on storagebits being the correct size expected by the SPI
> framework. Instead, derive the correct size from realbits since it will
> always be correct even when SPI offloads are used.
A more specific example with widths etc might be useful addition to this
commit message.

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


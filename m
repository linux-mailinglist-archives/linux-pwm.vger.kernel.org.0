Return-Path: <linux-pwm+bounces-4755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEBA24904
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898A61882290
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5981187859;
	Sat,  1 Feb 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbuB6Wex"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFCAD39;
	Sat,  1 Feb 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413209; cv=none; b=J2wD9BSowCcWCfdXlSQ+Z7v2D0mgOlfQ8ofVE6BadRC37mlIHIYfiwHdQRzA8sFlIFnWzMcMabLmCTwlXpY4a9JuZe0SnRYCLi2mOBr7fw3NqG84A3c6499vGPXP8OUza+C4XOXjju2wyPw5WTCmUmZABloXP6/ZW1uf+fh7epE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413209; c=relaxed/simple;
	bh=xr64e7/eF9N5UT/d8DQ8wGSF85r4VQzcT+WXuZPzXo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV7Nl7oaggp8yo8C59H9oU+njuHh9meOjwvQmHdSJYSbg74spP5Nwh5NftWQYCdPM95t0cwnPRwy0rCQ2+pgYVTy7uJRFGBc+IN1uXtLTyWU3cAmYGe4gQuALXG5SUrWpqa3PVy55SxYiMECQIldcyY8z5sAt0YwfGmuCjOQ9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbuB6Wex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C5C4CED3;
	Sat,  1 Feb 2025 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413209;
	bh=xr64e7/eF9N5UT/d8DQ8wGSF85r4VQzcT+WXuZPzXo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VbuB6WexeAHjfKequ3f5tg36VUVlZR2DYaYsqqI4DNP65Njau8YcHh5ni9HdpVblh
	 fQB6/Rw1Yv8MvoCGa5WJhlEwLnx6ry4VCJ5+FsBSK576Mvw+ltqRkgCxUkS2j9aonA
	 IcajQX+GyVyD4g8wlM4TW63FreWkfT05MUYjY6Rex6wr2svOZsTONgYtBKPeRkSgxz
	 f4XIhfDeucuhxPKHS789IS4uX2i0dQBVL8KuRQtdU3feel2kyaP+RZkvSv9FidTcy8
	 0Ey9OG5DwAyglFCZsMXkSceVK67km78V6065vyoTkAYtNHanEN4UGPzCJQ9qYzvIdw
	 jESKWnm9Iu6lQ==
Date: Sat, 1 Feb 2025 12:33:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] ADF4371 refin mode and doubler support
Message-ID: <20250201123320.08bc60fc@jic23-huawei>
In-Reply-To: <20250127101026.5320-1-antoniu.miclaus@analog.com>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:10:20 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting between single-ended and differential
> reference input. By default the single-ended input is enabled.
> 
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
> 
> Add support for the reference doubler. This feature is enabled
> automatically to improve noise performance if the input frequency
> is within the accepted range.
Applied to the togreg branch of iio.git with fix to patch 2.
I'll be rebasing that tree on rc1 when available so until then only
pushed out as testing.

Thanks,

Jonathan

> 
> Antoniu Miclaus (3):
>   dt-bindings: iio: adf4371: add refin mode
>   iio: frequency: adf4371: add refin mode
>   iio: frequency: adf4371: add ref doubler
> 
>  .../bindings/iio/frequency/adf4371.yaml       |  5 +-
>  drivers/iio/frequency/adf4371.c               | 47 ++++++++++++++++---
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 



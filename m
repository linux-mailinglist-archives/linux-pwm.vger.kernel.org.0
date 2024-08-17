Return-Path: <linux-pwm+bounces-3033-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D09558B0
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFC1F21C40
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039F83A17;
	Sat, 17 Aug 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCOS2MX9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CFD2E5;
	Sat, 17 Aug 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723908845; cv=none; b=i5ytIAJoUJfZsQ0TxKlhzsoJbiehRxenROrDVQHozQaPNe0pEDAyFHETMRtQQg716y5x5m66YuNQJxGAPdHMu49KjdJRcLHkWFoEr3IMwAdE23KYzn/RXOfW9/W6hIdGTw2nhOFBnT0eEu2HG1UAqlpB7I4hrhhxfP3D1wHPapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723908845; c=relaxed/simple;
	bh=P61hLlTE3CU9QrFc26cIC8xddi+vWGWzL0f2eUqIgms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBy+2WBelzPwyJBpJ3N7P3Ha6z7vKVEngJM1ubEPfRJS71bi7Aikzt82r6TNjqLVljXWVHw8jU+gV4HrpYZA/oqvyRMyNSXltVwBje9sPrOeP8AlyCfYeBQDy7dI945QEJsLL2ybHqUCcF8wRey3nkCyQwoSetnWyMKH05rJsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCOS2MX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC7CC116B1;
	Sat, 17 Aug 2024 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723908845;
	bh=P61hLlTE3CU9QrFc26cIC8xddi+vWGWzL0f2eUqIgms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCOS2MX9aJ/LCnu1OSpSsn0Xba/iCZ44XP992cTW+MQTOBC4PxBvNJ44Wy6JHe+eg
	 Tgb85tmo+faxLUuD3AFrvqEMayeQvnxwISXxP1Qt6OyPBTTeS2x+6huOpPZYOzIZ/h
	 eowdbnvUWJbV0txFDVd3Rz8Een0NwVUqbwsYZj4kZDwsZp7VvNiwTCQ+8BQMBMYSLW
	 1B8zDxLVTr1ebwY73knSM5KL2pyMi2zL4F55/BOXbocXZHEr32MNE9viX1ATN23WP+
	 t2gIk8Bf7z8Qc9ar7b/C3x1aYIGoIhaZJjoijoH8nI5m/uAEDnhePyofpEVbR7UnXD
	 ZbdjVeJwV0HCQ==
Date: Sat, 17 Aug 2024 16:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 7/8] iio: adc: ad7606: Switch to
 xxx_get_device_match_data
Message-ID: <20240817163354.68ec95f4@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:12:01 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> On the parallel version, the current implementation is only compatible
> with id tables and won't work with fx_nodes. So in this commit, the goal
> is to switch to use get_device_match_data, in order to simplify the
> logic of retrieving chip data.
> 
> Also, chip info is moved in the .h file so to be accessible to all the
> driver files that can set a pointer to the corresponding chip as the
> driver data.

This means each driver gets their own copy.

Better to use an extern in the header and keep the actual data
in the core module.

Otherwise LGTM.





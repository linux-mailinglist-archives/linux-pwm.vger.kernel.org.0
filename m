Return-Path: <linux-pwm+bounces-7087-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715CCB29D6B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 11:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390AB5E2395
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A13202C3A;
	Mon, 18 Aug 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="YAovJyNe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE9219EB
	for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508590; cv=none; b=N+lc4zvbD8pi5PCsqLQiigoZiBL9o+trarXrytAe49s/4PP3lARHmuV97EofUcC+SQ6IbqnRn4puMtkY/VKMn6TghVbOE4q4uOvefF9PYL7RuXr0mhj/28nu1WvrecU66WXRkfeJml/T03EngLId3sAGBS/CAt1tHf+jMxms1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508590; c=relaxed/simple;
	bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGvu9unQe1qS5/fqb48CSfBxUq6+wJUoDw8kZZ1rbirPIdjihK1wQC6sQk0N6lGEqiUuP9fJSHKNXQ/jisj8DQJar9sMajXbz7NQksihwieceABbhHSOEB6/ep0ziIMYvWODhIjCfVfOxaYrTZ3NZAlJdaTjmhqv1U9cbdB+hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=YAovJyNe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so30938845e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755508587; x=1756113387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
        b=YAovJyNe5zxCHo5TBYl+UL2QOQpuegFk98rMaoLockEF0tq5DvbERP+oqzYpvV4nDF
         LZsGPCjaW1J1irUFntNGJxMHACEOzA1bo/goGCwInAp/qPWmba0yAhDaxRx3zUgZlxrG
         eDTp0BmstUD5QWGzLSM03ZfOH/Rq7kAmLnhKFguZtrsmu6yXEQZkQLhRTgLxGAHppv3v
         BpJHG+hvJKL/LroFUL3NTA2DGdFA5HahKkS55J3nA+X/5ni8oRUK0rAabyhEbhqub9vz
         xmgdKHeMghGJxm06tgQu+Mhy3ZiW8UGN5ecNTQNxmMYFHYVp0xChCFvMHiLYaz5LHrPD
         jUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508587; x=1756113387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
        b=aO7hd3bCnI+pPm9Og2sB6l4Yui66G/LxXjMT8rJWIeh7N+AdhvscBA4apBgPp49k1P
         135yzd//KCfy9GACeqS6RmnOoKxS3nTQlVWWtOKTyrLUeSDp0a8dZE97T7FeBHN4oaCm
         ecbFlC+qI2Nol1uHcWbOJXdACM7ggFzwGeafXCY9q8QhpxIpJRrK5Rm4zGvzXSPC0YxZ
         MLvjLp6kOyCKw/OQ93rS9secfE98wQC9mzAn8HzPbIeE3WsN6O9JWu7YOOadcDSldBmG
         Y8eVN//q5M3uD5r5L8QEJX+D86v6+HXaQriX0x3JBGlpmRSDYO+POHs9NYZeRaYtQRxt
         mpfw==
X-Forwarded-Encrypted: i=1; AJvYcCV8QgkbZbcUAdopuFuHb3C+eHSPk8lvLRfjT8loOyTu3uGI66HCbjQbJhiMuXSlZcTFrT6nqXW5FHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzcK5uEazoROHpWwufT0VRk7GR349eq0+7MEKiuyVtoka350S
	dabhEoGI37O0jZEZ6yqUISTM0e6OPLCeI/zO0JqGQVNwil5eIur0RRBounllhTHgEYM=
X-Gm-Gg: ASbGncvDfVs5hlBR8q3OCXugAdcJJTL+5ADxMpnMX6PZCXsMCXbCtEStJ98x5EnWVN2
	C/VBd8klxHmgESMT9muQmBOLQikxLMF1TwG9nHWlW+sLsxhVAytRDrCXtsckpdGie9+o+6ZlURJ
	CkLV9F+ekx85aojKSUwCUQ1/P4gA6h37Erz9D4hN8hiP+teKR9LzuT5zrLdH/rYUbq+cxJjO+54
	XfXhXIdNFyYXpd6Q0qQ7TgEzGLOKaZoZjc8AUHAkX8ynkoW8+POo4ZhKEaKtKXD8BcDj7iS1jK6
	vXwpBA03ic1NfP2xy8eWatJ2ESrR1f0daHRgqJHTQ5Ulhu53wzFFoSRSzbnRm4k118QBC00ShXG
	Q4HXCY1QHERQvQfuooHnrO+lg5U3WH5joASrS9kQuB/5u8qKldVuN7o4vVoPgXxUgSZaEauugwd
	dUcBF+yA==
X-Google-Smtp-Source: AGHT+IHDUhr5tbZW68XtBaWVE5750X38A7H/faFXckj5O/o+hqZwSOPx/6BzSCyybhISbzqKROogNA==
X-Received: by 2002:a05:600c:45c6:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-45a2185dad9mr83576675e9.25.1755508587052;
        Mon, 18 Aug 2025 02:16:27 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079341sm11907856f8f.50.2025.08.18.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:16:26 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:16:24 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties
 without memset
Message-ID: <aKLvaP55PIVhyFSc@aspen.lan>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>

On Tue, Jul 01, 2025 at 11:22:37AM +0200, Uwe Kleine-König wrote:
> Assigning values to a struct using a compound literal (since C99) also
> guarantees that all unspecified struct members are empty-initialized, so
> it properly replaces the memset to zero.
>
> The code looks a bit nicer and more idiomatic (though that might be
> subjective?). The resulting binary is a bit smaller. On ARCH=arm with
> an allnoconfig + minimal changes to enable the mp3309c driver the
> difference is 12 bytes.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.


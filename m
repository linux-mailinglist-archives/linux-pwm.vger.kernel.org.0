Return-Path: <linux-pwm+bounces-4005-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6729B9845
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC91F1C20D22
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC61CEE84;
	Fri,  1 Nov 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J+YA+Pix"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9037B
	for <linux-pwm@vger.kernel.org>; Fri,  1 Nov 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488651; cv=none; b=s7P/jur6PAXR9teLa7X69NBMoNPfNj7UUW/sBb0r2Lh/UIhqlCeJ9vBKIAYaJlJ9Eld/6sMAwNZfnYjf3mgYEGFytjh0014GViERShISyzAd/E5c+aCZvr8XbhuQGD8ScJeQWfG74B+s7d1xpjvXG8FN2XgAQrEAO6HZrlPe7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488651; c=relaxed/simple;
	bh=o2R50UDnjLNhxbKIccKFZcW7BfLpfitiT8jylsK5MRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PGeCyZTggyWVXPMAQcwGJL3A4Wm9AS+dTcQ/fAOnmPGXxjBtEJXSvlIXObpMlSEhdI/bkxpugvQkuSTrF0HzvZbhTRsnKqyZymtCQ20c4M2K2FNu/SFjxlcGPwLJ0ef4iEVU51T6q63no3qjPTXqazTpfaG63VGXL/gFZZZvCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J+YA+Pix; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-288d70788d6so1165971fac.1
        for <linux-pwm@vger.kernel.org>; Fri, 01 Nov 2024 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730488649; x=1731093449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lG1xyYIDy+NadFUDAMAXUBdzTNgBK3y9dmr85eKtBik=;
        b=J+YA+PixiJ9XBNrMACQBl3fmIA8ZgzXtH37q4xi6UEiUJqKHws3CSZS6MSRjBYwD1B
         opvu8rasfJ/B3cjo8COXgMpjOaaqMivY3NzhZXcwuP1A9MHcrrDnVO8mvh/XPCCC8Q00
         pzteghD4rZc68J5xuduX0uXOZKvnMx4VmuIL8NSxjLpDXyhNFvo3yZ6VInT8vO2C+3JO
         S8Y2jFNJ2rBoCcQL1S2q7z5PfWso5KmMraONn1ihlGRYK7GYRXjj0P66uCDDEKpFrUGu
         MdFaIiEnHn+LS2W44qixkgmfqkeKX2EkP6Nj7bg3J9bpjYv/OZwWOkYiR7oopFbY3Y9a
         dLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488649; x=1731093449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG1xyYIDy+NadFUDAMAXUBdzTNgBK3y9dmr85eKtBik=;
        b=vJSI7vbpWqU0g/bOVJehk6XZisQ8vEF2tPkF1Il+xVmBsrXMR3iBcqcQQffSCFI2Fc
         6Ay9eoOWAXZo8KF+zyF6EKs+ByobCyM/LC3NmMhgMJpcwJVB7nYF3xY9TO7EYF/q7v6E
         zBQX1tIEwfYVl6tUL+h6eJFVxF2eIlika4OdzcPMo5T3KybdF9Z2B3nRnJuCk1vouqSz
         EVUMfplX+j5tOxhq2jsprFMkt73PcisjkE8zzA1SSsBpo8WAoqCd3iM9lQaqO5XpjQpb
         CEPsL9NUSE2e6h1JXcgCzFR36DjWER3sgTkZzsEb10dscXwqioZozgkffFxZuDMWaqlf
         1o8A==
X-Forwarded-Encrypted: i=1; AJvYcCVYgfJCF8xr4GTZV+8+uhDnJPqZJGqI2HtGM9byHSrGUXirGf/WSOS6ceQBZJZJbP1jUt9A9I48NwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2l8pPUBy620psa3suJSujdvv2+6BKX28M0LDZKj+bmErW1Bt
	tgSKw2SEMDPvU3NOHKTETxTx9i8khy/4t4LhKB4WDEDJ+ReQuDV7IZOtRCO0mLg=
X-Google-Smtp-Source: AGHT+IEOa+2fm/lTuefUxKi2PihQWSdi/i5GWKsBYila35cTgKcc9EAR2Tsl4pAafZZmRryhmKIgYw==
X-Received: by 2002:a05:6870:390a:b0:270:7a7:eaa5 with SMTP id 586e51a60fabf-29051af0d75mr22829984fac.10.1730488649452;
        Fri, 01 Nov 2024 12:17:29 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccdc696sm842144a34.81.2024.11.01.12.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:17:28 -0700 (PDT)
Message-ID: <0944871a-88b1-401c-96f7-0b0f7164eb30@baylibre.com>
Date: Fri, 1 Nov 2024 14:17:26 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>



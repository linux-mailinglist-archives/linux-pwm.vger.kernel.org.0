Return-Path: <linux-pwm+bounces-4241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EB9E4B6F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 01:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74042166A20
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE817543;
	Thu,  5 Dec 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fYKcZfQT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70ECA6F
	for <linux-pwm@vger.kernel.org>; Thu,  5 Dec 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359580; cv=none; b=GhCcIUMAYem+/SUGXxdo3Xf5yMEex31q2JAvd0G3NcuSjxP+dtxJ7gMHtMhMvrvwRG2o1/oFfosoMS+3V1df0PS4auky2X0V55hy9GBPGwBDmVgQXJ6GUcIXFnaRd7HdlZqbxlsavYPy/TjgEfU7C/cFilCRPcav3wtrD9VAfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359580; c=relaxed/simple;
	bh=2z0iKqJu1GJejrxfok3jyqtqP1mGC/thUx+YN2pvhFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKecuuDI3UysWxYkt2oE/eytlhTtHPqXNPY5EJ7a3LOIxqN6LTUkfDCOtW4MBRr1Wu+F5yoraHhWoHY0kZ+IzLY9+3Ly59TaP5zUO4tD0iDq7LFZie03YH7y+H836ppqkrnAgQGqRUQGy/JyZwhQdQEsQnZN9AbzLtP6fqrxSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fYKcZfQT; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71d41932d32so230391a34.0
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2024 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359578; x=1733964378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qStXvs/zcX62n3zX8u3CLNYt6qTW8moFcPaeP/VvQ0g=;
        b=fYKcZfQTZW+BlrkODYqkYVmGHmTckIv80hIgqzDDEOfUuyVyI8Tf9IjtlJjPEkXeAy
         oCyGq5S+dq3uumw9juQBIXaXX6KVC4Ed+lpq/+2GujmYcKEZdZBzFQ9Ekkwd0bQU30Mv
         LPOAKZbJKnsGWa/s3Y9vX9qf8/j96ATjNJRB14uJJ+LWKMjHxc7cUDFJUaW4hgXoVCk5
         1SX6kWjP8w9yr3fW+nV79pkJDz1U7gPqqOuN9nuBhfGwIdBtQXrfdVEK7jRiNRbk8M4w
         C78X61/giJ73ZJfJbN84EC8+dOazw+WNQkf1CjE8kwgaGzkhajrgD3cGz8ZIxAN4oiCX
         Zlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359578; x=1733964378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qStXvs/zcX62n3zX8u3CLNYt6qTW8moFcPaeP/VvQ0g=;
        b=PRl3rsMai/CXok2YKzUPljtTR8uzn36jdnlje7wouo9OHIHQS5Lsgr5pazCnps9lZZ
         InONaJGRKJjmaRQ9vAGNQ3a2GI6BEfiW0L9X7G3lhS/oq6x98zN/mU+uV5zdYdn0ZfdO
         hr8I/iXg9Nyjqcs+gdmITx6SpzMxKU3zxvergJMVzA08xMAef0nVNsZfpoa+z2vxzz0h
         peQWfruTyWGnLnzf0vxoEFHq+vwl3m7WPLdsjKXhpwivD/Q9W0RVc/0vUy+vDV/GBlQS
         2V2whuk+O4h5Jo/e3aCncMu3JvQwGJUVMQJPwaidS5xVMkmZh5wXLiK9Et2S/TcnDpba
         iSug==
X-Forwarded-Encrypted: i=1; AJvYcCW408KVSL83ApCZugjBJTHpbMxCcVQa+Arc53v+xpVsMAZ5GtMbzfbtxjLFxAAfeBjb+nXij8vnf78=@vger.kernel.org
X-Gm-Message-State: AOJu0YydvoLfPcLMl35cxGt+Pao67EdcxD04roLDerRFHarDvVlh1gj/
	5DFGqRdiovs3099212iDq1ziK/v0QH7GgOD3c84S5wkVWd23qkL5WYbAYY6FU1A=
X-Gm-Gg: ASbGnct+wASPcv+Vh9c6SvYhn+2W9EM+VUWVesOcZv4CrEaTr9zUh4QW/EWk4IMCjps
	PDrvTkM5cpD2TkyGfH5YmxH0IR+Ze7clekck85e8SwG1+o+ataK/xVzT4HK7UeNWQH3GvKTRv+8
	WAEC+K6j1xhJ28yEykJkZic/KYk0iU8Qxx+44gP40nFETj1xwSwqZlLL1akxeYzS0RSw9V33yrG
	2yF09Zdg3OHM1mbswzL6ytNKU8rTk5lMfefjvDbue0BrdRKuUKSiKr5FRLL9SychHM4U2REpsZF
	QqGKu8uWmrg=
X-Google-Smtp-Source: AGHT+IGnMa8pjHhI6ipUO0fiWTjR601DUJqqzeZSFC1UmSfdr9z+Kj03mH/trfcErz+eVgRfBurCog==
X-Received: by 2002:a9d:63d7:0:b0:717:f666:9559 with SMTP id 46e09a7af769-71dad610a7amr7951902a34.9.1733359577951;
        Wed, 04 Dec 2024 16:46:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc493b027sm111901a34.14.2024.12.04.16.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:46:16 -0800 (PST)
Message-ID: <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
Date: Wed, 4 Dec 2024 18:46:15 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-8-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-8-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for ad485x family.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - add adc channels support

What is the reason for this change? In a previous version of this series,
you explained that we didn't want to specify diff-channels in the DT
because there was a use case to use channels as both single-ended and
differential at runtime. So I am surprised to see this being added now.

> +patternProperties:
> +  "^channel(@[0-7])?$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 7
> +
> +      diff-channels: true
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +


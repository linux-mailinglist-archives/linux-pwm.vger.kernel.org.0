Return-Path: <linux-pwm+bounces-8896-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDRTM+m0CGr31wMAu9opvQ
	(envelope-from <linux-pwm+bounces-8896-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:18:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4442455D0E1
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4DF30125C9
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F4026B2D3;
	Sat, 16 May 2026 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="IZbzvft0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F5199920
	for <linux-pwm@vger.kernel.org>; Sat, 16 May 2026 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955490; cv=none; b=cRrPGdyyfFA/mq0SXy3AHIWAGxwJbSY4BEdv0nWumEodO6AgWEHQKE7Kp9FSAPVYQ9Q6y50V8ImfCTmenihAQET+E3vF83c0wLK9MeYJw7cexhROlfc8465DHsAZldFybj9hFsDr92iAOQ5OYwKxOPLBfBHRYsom+GmIqy/G53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955490; c=relaxed/simple;
	bh=/qEtG+RVBPIzxD9LT6Y4vWiwm+rUQ4i7wfGw9xfnh8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb0YWW3/xAxvrYdRwuxyzPlqYc4sZ4t9q70g85FA/T7xPkVRAz8RZV7JlcQ47G7PXDTtAOW7ZE83TXUgnNTJuaPFQZD9cfJdXYt0PvCG5+1ElWHb7SSnp2F+TuQeiivuyP15B4T+GJ+TUK7PJUO45eWM9LS8VaEvd/BgJEWh3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=IZbzvft0; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-694891f8f62so366844eaf.2
        for <linux-pwm@vger.kernel.org>; Sat, 16 May 2026 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778955486; x=1779560286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vUt23i4NQCqZR50VDzgD/PyoHZA+01KM295cLKfk0c=;
        b=IZbzvft01BRTPcK/p8m35xNiQ+8j19L20jNDfib4/lAAi2NoHFzhDBfWHq92NeWWp1
         Ly2IEp+WkuNkAtDb6i9sLy6fwHMwwcR7f+tasp5XW0u+chHWmVB+MDh8C2KUrDjY1MKg
         eUNMWkT8s8Ty1H2t9KZRheyAZCMVgqjCKROdO1qUB0rJ+oqCD38gKnPPHkv8F248BFRD
         nl6hSfkGQ2XcpnERwx4e7U1CyEDChlRHUl/tjvTON3E63AaB3T2tHQhEozJppMkQh2bJ
         vcr6Qbox9VAyRj287+k1UssLzHV8wFgU/IUuTOu79V5yCONrH+bYnXNdMGu+K2V515RI
         SNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778955486; x=1779560286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vUt23i4NQCqZR50VDzgD/PyoHZA+01KM295cLKfk0c=;
        b=H7gOE94jN3R2hi1/QIuNkcV3p1KGG4/fVjiqYwr+wJehtlmt2ptoRECPlHdbPB94zR
         JRd9zppbmD8vup/sIkOAkDNYoPdSmMX2dWuCnp6Lz2MxMfjT+c3PoLTVtI9rQIySUsmA
         CJtdYhvYm7lvCE20moIxrmq32eG/s6TG+2W3+fx8/8ZLjbXr5AR3+Od2WHa+uMP8XQf4
         aT/hCAHBbOGQD+j1YnjlMz5RDCCMfYQ0EnuF3BhvxnYmD3+NJxmGChOSbFxkRdtyFVCx
         1DwKIEOiv5/XOaJuN87yAbQeS0nkUd5NidGXs2NNhmq4OZSfm8pnfyx4Y49xu42L1UBg
         HRMg==
X-Forwarded-Encrypted: i=1; AFNElJ9btj2MepXc07DaIyn2WxNNtBlfqOVvBaz2fgycAMPwTx01P/u3dGo8gVuzmQLANoSi7rLJRaaR6Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaDzOuw0JqUPkDjk8P8uut58XPjC0+7ZZHlkuDUZSRSRontvr
	zg2LmHbi+hlsXoDfWrvUCHUDYZZoAyfXbhUmImwp7lO609afZAGRP99yL2LRyAEJDz0=
X-Gm-Gg: Acq92OH9ZqWOMhKdzgXlBUieeL3iTPOlaf+2iL2De7wRi3Io41M2HU0mM3kZoPqnc1W
	FsQLl4dLha9Vsq2Zd6rlPbKFLbpoyhQH9Xb9QSeg4lhnpmqUBfHR1sj/Q629ZwW7kj5ynqIAUpw
	ovrQRJmno1+qKjnYa3F+PVWVGh9APkDl75OL3/vLMIrTzw+rqrdkin5wgYJWrl1YuL5vRw3TbgN
	5uUi5BAtl9jXQqYSstMPl08vu9hscAf3NxWvrO2QEguMwai+bgFT9StYkyB/+g6as8BWD5r6Fia
	0CRX7ixFsPEZL05bGbwg6SKnaJ9aHwP3sOIQzBN8Mhs/gnYlJWnXybCzHNu5/rXdWY3ZiX92g3c
	WY4PpHgGkwjx4j0h/iESQsco6gZKJxAQ5nYz9qOlJ1chtYCdBZbShITOZCQGcYMx+TMEeUSr1I1
	ot6/yUPZ/gOoWTs6YOjqcdT6k74tRzSy2ficD+0BpGDpCZCEKDVo+LOLwoI4Xs4RPYdiJbBz5TZ
	g==
X-Received: by 2002:a05:6820:f012:b0:69b:56aa:1525 with SMTP id 006d021491bc7-69c940a22b4mr5473008eaf.0.1778955486426;
        Sat, 16 May 2026 11:18:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d04655cbcsm2718778eaf.8.2026.05.16.11.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 11:18:05 -0700 (PDT)
Message-ID: <78d4bb1c-4c6d-4781-86ee-458579ac6990@baylibre.com>
Date: Sat, 16 May 2026 13:18:03 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/6] docs: iio: adc: ad4691: add driver documentation
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-6-eab27d852ac2@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-6-eab27d852ac2@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4442455D0E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8896-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,analog.com:email,analog.com:url]
X-Rspamd-Action: no action

On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add RST documentation for the AD4691 family ADC driver covering
> supported devices, IIO channels, operating modes, oversampling,
> reference voltage, LDO supply, reset, GP pins, SPI offload support,
> and buffer data format.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  Documentation/iio/ad4691.rst | 225 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 227 insertions(+)
> 
> diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
> new file mode 100644
> index 000000000000..84492ef7a5d6
> --- /dev/null
> +++ b/Documentation/iio/ad4691.rst
> @@ -0,0 +1,225 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4691 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD4691 family of multichannel SAR ADCs.
> +The module name is ``ad4691``.
> +
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD4691 <https://www.analog.com/en/products/ad4691.html>`_ — 16-channel, 500 kSPS
> +* `AD4692 <https://www.analog.com/en/products/ad4692.html>`_ — 16-channel, 1 MSPS
> +* `AD4693 <https://www.analog.com/en/products/ad4693.html>`_ — 8-channel, 500 kSPS
> +* `AD4694 <https://www.analog.com/en/products/ad4694.html>`_ — 8-channel, 1 MSPS
> +
> +
> +IIO channels
> +============
> +
> +Each physical ADC input maps to one IIO voltage channel. The AD4691 and AD4692
> +expose 16 channels (``voltage0`` through ``voltage15``); the AD4693 and AD4694
> +expose 8 channels (``voltage0`` through ``voltage7``).
> +
> +All channels share a common scale (``in_voltage_scale``), derived from the
> +reference voltage. Each channel independently exposes:
> +
> +* ``in_voltageN_raw`` — single-shot ADC result
> +* ``in_voltageN_sampling_frequency`` — per-channel effective output rate,
> +  defined as the internal oscillator frequency divided by the channel's
> +  oversampling ratio. Writing this attribute selects the nearest achievable
> +  rate for the current OSR; the value read back reflects the actual rate after
> +  snapping to the closest valid oscillator entry.
> +* ``in_voltageN_sampling_frequency_available`` — list of achievable effective
> +  rates for the channel's current oversampling ratio. The list updates
> +  dynamically when the oversampling ratio changes.
> +
> +The following attributes are only available in CNV Burst Mode:
> +
> +* ``in_voltageN_oversampling_ratio`` — per-channel hardware oversampling depth;
> +  see `Oversampling`_ below.
> +* ``in_voltageN_oversampling_ratio_available`` — valid ratios: 1, 2, 4, 8, 16,
> +  32.
> +
> +
> +Operating modes
> +===============
> +
> +The driver supports two operating modes, selected automatically from the
> +device tree at probe time.
> +
> +Manual Mode
> +-----------
> +
> +Selected when no ``pwms`` property is present in the device tree. The CNV pin
> +is tied to the SPI chip-select: every CS assertion triggers a conversion and
> +returns the previous result. A user-defined IIO trigger (e.g. hrtimer trigger)
> +drives the buffer.
> +
> +Oversampling is not supported in Manual Mode.
> +
> +CNV Burst Mode
> +--------------
> +
> +Selected when a ``pwms`` property is present in the device tree. A PWM drives
> +the CNV pin at the configured conversion rate. A GP pin wired to the SoC and
> +declared in the device tree signals DATA_READY at the end of each burst,
> +triggering a readout of all active channel results into the IIO buffer.
> +
> +The buffer output rate is controlled by the ``sampling_frequency`` attribute
> +on the IIO buffer. In practice the PWM rate should be set low enough to allow
> +the SPI readout to complete before the next conversion burst begins.
> +
> +Autonomous Mode (idle / single-shot)
> +-------------------------------------
> +
> +When the IIO buffer is disabled, ``in_voltageN_raw`` reads perform a single
> +conversion on the requested channel using the internal oscillator. The
> +oscillator is started and stopped around each read to save power.
> +
> +
> +Oversampling
> +============
> +
> +In CNV Burst Mode each channel has an independent hardware accumulator that
> +averages a configurable number of successive conversions. The result is always
> +returned as a 16-bit mean, so ``realbits`` and ``storagebits`` are unaffected

realbits and storagebits are driver implementation details. I would write this
in terms of userpace, which would be the buffer0/*_type attribute.

> +by the oversampling ratio. Valid ratios are 1, 2, 4, 8, 16 and 32; the default
> +is 1 (no averaging). Oversampling is not supported in Manual Mode.
> +
> +.. code-block:: bash
> +
> +    # Set oversampling ratio to 16 on channel 0
> +    echo 16 > /sys/bus/iio/devices/iio:device0/in_voltage0_oversampling_ratio
> +
> +    # Read the resulting effective sampling frequency
> +    cat /sys/bus/iio/devices/iio:device0/in_voltage0_sampling_frequency
> +
> +Writing ``oversampling_ratio`` stores the new depth for that channel and
> +snaps the internal oscillator to the largest valid table entry that is both
> +less than or equal to ``old_effective_rate × new_osr`` and evenly divisible
> +by ``new_osr``. This preserves an integer read-back of
> +``in_voltageN_sampling_frequency`` after the change and keeps the oscillator
> +as close as possible to the previous effective rate.
> +
> +All channels share one internal oscillator. Writing ``sampling_frequency`` for
> +any channel updates the oscillator and therefore affects the effective rate
> +read back from all other channels.
> +
> +
> +Reference voltage
> +=================
> +
> +The driver supports two reference configurations, mutually exclusive:
> +
> +* **External reference** (``ref-supply``): a voltage between 2.4 V and 5.25 V
> +  supplied externally.
> +* **Buffered internal reference** (``refin-supply``): an internal reference
> +  buffer is enabled by the driver.
> +
> +Exactly one of ``ref-supply`` or ``refin-supply`` must be present in the
> +device tree. The reference voltage determines the full-scale range reported
> +via ``in_voltage_scale``.
> +
> +
> +LDO supply
> +==========
> +
> +The chip contains an internal LDO that powers part of the analog front-end.
> +The supply configuration is mutually exclusive:
> +
> +* **External VDD** (``vdd-supply``): an external 1.8 V supply is used directly;
> +  the internal LDO is disabled.
> +* **Internal LDO** (``ldo-in-supply``): the internal LDO is enabled and fed
> +  from the ``ldo-in`` regulator. Use this when no external 1.8 V VDD is present.
> +
> +Exactly one of ``vdd-supply`` or ``ldo-in-supply`` must be provided.
> +
> +
> +Reset
> +=====
> +
> +The driver supports two reset mechanisms:
> +
> +* **Hardware reset** (``reset-gpios`` in device tree): asserted at probe by
> +  the reset controller framework.
> +* **Software reset** (fallback when ``reset-gpios`` is absent): written
> +  automatically at probe.
> +
> +
> +GP pins and interrupts
> +======================
> +
> +The chip exposes up to four general-purpose (GP) pins. In CNV Burst Mode
> +(non-offload), one GP pin must be wired to an interrupt-capable SoC input and
> +declared in the device tree using the ``interrupts`` and ``interrupt-names``
> +properties. The ``interrupt-names`` value identifies which GP pin is used
> +(``"gp0"`` through ``"gp3"``).
> +
> +Example device tree fragment::
> +
> +    adc@0 {
> +        compatible = "adi,ad4692";
> +        ...
> +        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gpio0>;

Would be more logical to put interrupt-parent before interrupts.

> +        interrupt-names = "gp0";
> +    };
> +
> +
> +SPI offload support
> +===================
> +
> +When a SPI offload engine (e.g. the AXI SPI Engine) is present, the driver
> +uses DMA-backed transfers for CPU-independent, high-throughput data capture.
> +SPI offload is detected automatically at probe; if no offload hardware is
> +available the driver falls back to the software triggered-buffer path.
> +
> +Two SPI offload sub-modes exist:
> +
> +CNV Burst offload
> +-----------------
> +
> +Used when a ``pwms`` property is present and SPI offload is available. The PWM
> +drives CNV at the configured rate; on DATA_READY the offload engine reads all
> +active channel results and streams them directly to the IIO DMA buffer with no
> +CPU involvement. The GP pin used as DATA_READY trigger is supplied by the
> +trigger-source consumer at buffer enable time; no ``interrupt-names`` entry is
> +required.
> +
> +Manual offload
> +--------------
> +
> +Used when no ``pwms`` property is present and SPI offload is available. A
> +periodic SPI offload trigger controls the conversion rate and the offload engine
> +streams results directly to the IIO DMA buffer.
> +
> +The ``sampling_frequency`` attribute on the IIO buffer controls the trigger
> +rate (in Hz). The initial rate is 100 kHz.
> +
> +Oversampling is not supported in Manual Mode.
> +
> +
> +Buffer data format
> +==================
> +
> +The sample format in the IIO buffer depends on whether SPI offload is in use.
> +
> +Software triggered-buffer path (no SPI offload)
> +------------------------------------------------
> +
> +Each active channel occupies one 16-bit big-endian slot (``storagebits=16``,
> +``endianness=be``). Active channels are packed densely in scan-index order,
> +followed by a 64-bit software timestamp appended by the IIO core.
> +
> +SPI offload path
> +----------------
> +
> +Each active channel occupies one 16-bit CPU-native slot (``storagebits=16``,
> +``endianness=cpu``). The SPI offload engine streams 16-bit words directly from
> +the SPI Engine into the DMA buffer; no software timestamp is appended.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index ba3e609c6a13..007e0a1fcc5a 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -23,6 +23,7 @@ Industrial I/O Kernel Drivers
>     ad4000
>     ad4030
>     ad4062
> +   ad4691
>     ad4695
>     ad7191
>     ad7380
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24e4502b8292..875ea2455d91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> +F:	Documentation/iio/ad4691.rst
>  F:	drivers/iio/adc/ad4691.c
>  
>  ANALOG DEVICES INC AD4695 DRIVER
> 



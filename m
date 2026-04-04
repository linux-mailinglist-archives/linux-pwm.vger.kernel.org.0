Return-Path: <linux-pwm+bounces-8475-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH5uO5Qv0WlaGQcAu9opvQ
	(envelope-from <linux-pwm+bounces-8475-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 17:34:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B139B9EF
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 429AF300E5E1
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2026 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A631960A;
	Sat,  4 Apr 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="I+7nU80C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E31714B
	for <linux-pwm@vger.kernel.org>; Sat,  4 Apr 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316876; cv=none; b=dkOrqbnfzND/uZ98rIUylenAQidmOrA4qZ/4JZQ5F1qdXh8OJwelHSzpsb8zjJartRHvgUXP4Bchk7l/toxYNs0WJS2IxVMn+B6sWBUX8lIZm0ORybKBqrJyrvmL+C43DF9PuoPfRwtK1a1HCmbkhMbitSyZdy/nPtukFeuGaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316876; c=relaxed/simple;
	bh=G6SnkhOr1As6FBry8Y9C+66hbGOqOMztZoUWLj98G3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzwbM3ZQgwWR2kc0RMNjBFEt+9HMYE7llPKjTOYKo+ltd0oZNNgQHtBBpOnkPXZUSx6QF6oHAFlGUIuadUmxhgZJw99rj1af4Rj1f9NGn2+1hN/65DMsNQo1nu/0DxCCHAuiXq1dUyxxJFKczH0iHjLDNacHkxM6i/NMjICx/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=I+7nU80C; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1279eced0b9so3106489c88.0
        for <linux-pwm@vger.kernel.org>; Sat, 04 Apr 2026 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775316872; x=1775921672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNIG7oIixMtjXoOLBTF4Km9l7YWSSk5sSBtCTRK9+1s=;
        b=I+7nU80CT2MQ5/bERnsTkyLfdhVcN2ESCof2BHYIjoDDHBjVa8UNBZAxjcQK6a++9K
         8lBhyNrqkuOr/Jusy3y+iu8uiXkGEGrkSUoquTTzEBAQsFkL593viXszR1nDlRJ+y+5/
         t5fVz/2Hjyff6rTcGR2/BjRKaMAe+F95LaGSYn3bZEh/V0iGLWgKPwGyLibnc5oXdFxb
         Qa4HFHqUchQpp94JSFnf6LLjUuviztpedFWKEzHJxgDQWrhuGZwhr6LnF8XzS0TZ8YXy
         XoiYJphm5pQvFOS1ehFJ8iEg/sEIRWGHK8gKNksdbCh6YD4sOv+Mr333XASrzPKiQMxt
         fxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316872; x=1775921672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNIG7oIixMtjXoOLBTF4Km9l7YWSSk5sSBtCTRK9+1s=;
        b=kqePrSmNFadrMzy39orecqti6a+illXRsD6Lhsir48h/z4jPiz5W35QUcWmqwlt+pD
         wa0VVf/gnYmWakhh/9sYVVs6e2R2zOa42DTes7fzm6bhAXgH6U6rhWcyDKyBVR/z5ctA
         i2xVSR4zRVaZfcMu98VULzQJ3IiJ4dGY22KIaUMhmCpldYmIHpjQyD2QlcUtriIv1n5P
         qgTZep5lAun6YhLLBR70U+QVv/vKGG2NYvy5ikwdWEaOFqvn0WS9ZebZ4qyGMJtS9VGI
         32iqI/8CeD7LxLw8AJdTVCjTj9lLujSPf0+fUyihHCt3Hf73TygHz1r80P9xxuz5gokG
         P4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW6OeRRZHb7apCdHmWNxNs/2o7T9X5DxHtAiZD9bxPHB3nYLkcyNA/Y5+pSlJnOSwQNWJYGMPWBz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicsBXlASjVoKb6VcN2YpBwn1Gn+zjJ6a9GTOmPy6dw/aHLyQ4
	XLFi7IeFhYjnSGU/0NKWTpe4e2HqFk7X/RsvMGh/+f+wA3QD20fzCx/XPysYWcnCKn0=
X-Gm-Gg: AeBDievLVFuHaT+YFKiCgz3UQ5fWD1uLKGAzGl8SsqC/pX6fXodjr+vM6VOoQHznoAz
	R94A5dgZDS/+78KVahzHozpZcgcHI8PpblnjfK5ZP8d8ShGAYHixEd2IhSrIBW4mY7ck0Ldldkx
	bH1A5eJmqnXeu+qYA7T+RD/N2JIj38kLZK4cksda+a64yo/IDHQ965IZa0tNVoYjLOnM4rpt3Wt
	0sBfqToSP2i82US4mLmxQTmGETYMqSNiGu/KtQsV9abM6PCNrFpEpiW538ep95Pk73sw0EnLhio
	jjwgYJsXeM8HlmYi3Z8wRzTBD7/35ezNzfkq+DX+sYJDE+glllfVVEuIbGeytQ/4qxdHW+kVvFW
	3sgao9BygeHu8LMhkSJ190fmBGt8bk3KqfakxJ9hHiNl/ZMsvcxMIhtmbUefluUrVU2IzPr3I2z
	OnPl3K+uGgjJKeEz/ecoDtZq8hvnuGECJ9FWB9ViHHvuTzhtHSWpUIKk5oudpCvv28gxvkVdV2b
	Q==
X-Received: by 2002:a05:7022:e09:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12bfb63267fmr3266514c88.0.1775316872075;
        Sat, 04 Apr 2026 08:34:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e623sm7107228c88.3.2026.04.04.08.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 08:34:31 -0700 (PDT)
Message-ID: <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
Date: Sat, 4 Apr 2026 10:34:29 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
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
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8475-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:url,0.0.0.0:email,baylibre-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE1B139B9EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:03 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add SPI offload support to enable DMA-based, CPU-independent data
> acquisition using the SPI Engine offload framework.
> 
> When an SPI offload is available (devm_spi_offload_get() succeeds),
> the driver registers a DMA engine IIO buffer and uses dedicated buffer
> setup operations. If no offload is available the existing software
> triggered buffer path is used unchanged.
> 
> Both CNV Burst Mode and Manual Mode support offload, but use different
> trigger mechanisms:
> 
> CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
> signal on the GP pin specified by the trigger-source consumer reference
> in the device tree (one cell = GP pin number 0-3). For this mode the
> driver acts as both an SPI offload consumer (DMA RX stream, message
> optimization) and a trigger source provider: it registers the
> GP/DATA_READY output via devm_spi_offload_trigger_register() so the
> offload framework can match the '#trigger-source-cells' phandle and
> automatically fire the SPI Engine DMA transfer at end-of-conversion.
> 
> Manual Mode: the SPI Engine is triggered by a periodic trigger at
> the configured sampling frequency. The pre-built SPI message uses
> the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
> for N active channels (the first result is discarded as garbage from
> the pipeline flush) and the remaining N results are captured by DMA.
> 
> All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
> DMA word alignment. This patch promotes the channel scan_type from
> storagebits=16 (triggered-buffer path) to storagebits=32 to match the
> DMA word size; the triggered-buffer paths are updated to the same layout
> for consistency. CNV Burst Mode channel data arrives in the lower 16
> bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
> 16 bits (shift=16), matching the 4-byte SPI transfer layout
> [data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
> encodes the shift=16 scan type for manual mode.
> 
> Add driver documentation under Documentation/iio/ad4691.rst covering
> operating modes, oversampling, reference voltage, SPI offload paths,
> and buffer data layout; register in MAINTAINERS and index.rst

Documentation should be separate patch. It covers more than just SPI
offload.

> 
> Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  Documentation/iio/ad4691.rst | 259 ++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  drivers/iio/adc/Kconfig      |   1 +
>  drivers/iio/adc/ad4691.c     | 422 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 676 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
> new file mode 100644
> index 000000000000..36f0c841605a
> --- /dev/null
> +++ b/Documentation/iio/ad4691.rst
> @@ -0,0 +1,259 @@
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
> +* ``in_voltageN_sampling_frequency`` — internal oscillator frequency used for

As mentioned in another patch, sampling_frquency != osciallator frequency when
oversampling ratio != 1. So this needs to be changed to reflect that.

> +  single-shot reads and CNV Burst Mode buffered captures
> +* ``in_voltageN_sampling_frequency_available`` — list of valid oscillator
> +  frequencies
> +* ``in_voltageN_oversampling_ratio`` — per-channel hardware accumulation depth
> +* ``in_voltageN_oversampling_ratio_available`` — list of valid ratios
> +
> +
> +Operating modes
> +===============
> +
> +The driver supports two operating modes, auto-detected from the device tree at
> +probe time. Both modes transition to and from an internal Autonomous Mode idle
> +state when the IIO buffer is enabled and disabled.
> +
> +Manual Mode
> +-----------
> +
> +Selected when no ``pwms`` property is present in the device tree. The CNV pin
> +is tied to the SPI chip-select: every CS assertion both triggers a new
> +conversion and returns the result of the previous one (pipelined N+1 scheme).
> +
> +To read N channels the driver issues N+1 SPI transfers in a single optimised
> +message:
> +
> +* Transfers 0 to N-1 each carry ``AD4691_ADC_CHAN(n)`` in the TX byte to
> +  select the next channel; the RX byte of transfer ``k+1`` contains the result
> +  of the channel selected in transfer ``k``.
> +* Transfer N is a NOOP (0x00) to flush the last conversion result out of the
> +  pipeline.
> +
> +The external IIO trigger (``pollfunc_store_time``) drives the trigger handler,

I'm not sure "external" is the best word to describe this. I would say a "user-
defined IIO triger (e.g. hrtimer trigger)".

> +which executes the pre-built SPI message and pushes the scan to the buffer.
> +
> +CNV Burst Mode
> +--------------
> +
> +Selected when a ``pwms`` property is present in the device tree. The PWM drives
> +the CNV pin independently of SPI at the configured conversion rate, and a GP
> +pin (identified by ``interrupt-names``) asserts DATA_READY at end-of-burst to
> +signal that the AVG_IN result registers are ready to be read.
> +
> +The IRQ handler stops the PWM, fires the IIO trigger, and the trigger handler

If we stop the PWM after an IRQ, then we don't get a consistent sample rate.
Ideally, we would leave the PWM running and just pick a rate slow enough that
there is plenty of time to read the data. Otherwise, this mode doesn't seem
particularly useful.

> +reads all active ``AVG_IN(n)`` registers in a single optimised SPI message and
> +pushes the scan to the buffer.
> +
> +The buffer sampling frequency (i.e. the PWM rate) is controlled by the
> +``sampling_frequency`` attribute on the IIO buffer. Valid values span from the
> +chip's minimum oscillator rate up to its maximum conversion rate
> +(500 kSPS for AD4691/AD4693, 1 MSPS for AD4692/AD4694).

Valid, but not usable without SPI offload.

> +
> +Autonomous Mode (idle / single-shot)
> +-------------------------------------
> +
> +The chip idles in Autonomous Mode whenever the IIO buffer is disabled. In this
> +state, ``read_raw`` requests (``in_voltageN_raw``) use the internal oscillator
> +to perform a single conversion on the requested channel and read back the
> +result from the ``AVG_IN(N)`` register. The oscillator is started and stopped
> +for each read to save power.
> +
> +
> +Oversampling
> +============
> +
> +Each channel has an independent hardware accumulator (ACC_DEPTH_IN) that
> +averages a configurable number of successive conversions before DATA_READY
> +asserts. The result is always returned as a 16-bit mean from the ``AVG_IN``
> +register, so the IIO ``realbits`` and ``storagebits`` are unaffected by the
> +oversampling ratio.
> +
> +Valid ratios are 1, 2, 4, 8, 16 and 32. The default is 1 (no averaging).
> +
> +.. code-block:: bash
> +
> +    # Set oversampling ratio to 16 on channel 0
> +    echo 16 > /sys/bus/iio/devices/iio:device0/in_voltage0_oversampling_ratio
> +
> +When OSR > 1 the effective conversion rate for ``read_raw`` is reduced
> +accordingly, since the driver waits for 2 × OSR oscillator periods before
> +reading the result.
> +
> +
> +Reference voltage
> +=================
> +
> +The driver supports two reference configurations, mutually exclusive:
> +
> +* **External reference** (``ref-supply``): a voltage between 2.4 V and 5.25 V
> +  supplied externally. The internal reference buffer is disabled.
> +* **Buffered internal reference** (``refin-supply``): An internal reference
> +  buffer is used. The driver enables ``REFBUF_EN`` in the REF_CTRL register
> +  when this supply is used.
> +
> +Exactly one of ``ref-supply`` or ``refin-supply`` must be present in the
> +device tree.
> +
> +The reference voltage determines the full-scale range:
> +
> +.. code-block::
> +
> +    full-scale = Vref / 2^16  (per LSB)
> +
> +
> +LDO supply
> +==========
> +
> +The chip contains an internal LDO that powers part of the analog front-end.
> +The LDO input can be driven externally via the ``ldo-in-supply`` regulator. If
> +that supply is absent, the driver enables the internal LDO path (``LDO_EN``
> +bit in DEVICE_SETUP).
> +
> +
> +Reset
> +=====
> +
> +The driver supports two reset mechanisms:
> +
> +* **Hardware reset** (``reset-gpios`` in device tree): the GPIO is already
> +  asserted at driver probe by the reset controller framework. The driver waits
> +  for the required 300 µs reset pulse width and then deasserts.
> +* **Software reset** (fallback when ``reset-gpios`` is absent): the driver
> +  writes the software-reset pattern to the SPI_CONFIG_A register.
> +
> +
> +GP pins and interrupts
> +======================
> +
> +The chip exposes up to four general-purpose (GP) pins that can be configured as
> +interrupt outputs. In CNV Burst Mode (non-offload), one GP pin must be wired to

Or trigger sources.

> +an interrupt-capable SoC input and declared in the device tree using the
> +``interrupts`` and ``interrupt-names`` properties.
> +
> +The ``interrupt-names`` value identifies which GP pin is used (``"gp0"``
> +through ``"gp3"``). The driver configures that pin as a DATA_READY output in
> +the GPIO_MODE register.
> +
> +Example device tree fragment::
> +
> +    adc@0 {
> +        compatible = "adi,ad4692";
> +        ...
> +        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gpio0>;
> +        interrupt-names = "gp0";
> +    };
> +
> +
> +SPI offload support
> +===================
> +
> +When a SPI offload engine (e.g. the AXI SPI Engine) is present, the driver
> +uses DMA-backed transfers for CPU-independent, high-throughput data capture.
> +SPI offload is detected automatically at probe via ``devm_spi_offload_get()``;
> +if no offload hardware is available the driver falls back to the software
> +triggered-buffer path.
> +
> +Two SPI offload sub-modes exist, corresponding to the two operating modes:
> +
> +CNV Burst offload
> +-----------------
> +
> +Used when a ``pwms`` property is present and SPI offload is available.
> +
> +The PWM drives CNV at the configured rate. On DATA_READY the SPI offload
> +engine automatically executes a pre-built message that reads all active
> +``AVG_IN`` registers and streams the data directly to an IIO DMA buffer with
> +no CPU involvement. A final state-reset transfer re-arms DATA_READY for the
> +next burst.
> +
> +The GP pin used as DATA_READY trigger is supplied by the trigger-source
> +consumer (via ``#trigger-source-cells``) at buffer enable time; no
> +``interrupt-names`` entry is required in this path.
> +
> +The buffer sampling frequency is controlled by the ``sampling_frequency``
> +attribute on the IIO buffer (same as the non-offload CNV Burst path).
> +
> +Manual offload
> +--------------
> +
> +Used when no ``pwms`` property is present and SPI offload is available.
> +
> +A periodic SPI offload trigger controls the conversion rate. On each trigger
> +period, the SPI engine executes an N+1 transfer message (same pipelined scheme

How does this work with oversampling?

> +as software Manual Mode) and streams the data directly to the IIO DMA buffer.
> +
> +The ``sampling_frequency`` attribute on the IIO buffer controls the trigger
> +rate (in Hz). The default is the chip's maximum conversion rate.
> +
> +
> +Buffer data format
> +==================
> +
> +The IIO buffer data format (``in_voltageN_type``) depends on the active path:
> +
> ++-------------------------+-------------+-------------+-------+
> +| Path                    | storagebits | realbits    | shift |
> ++=========================+=============+=============+=======+
> +| Triggered buffer        | 16          | 16          | 0     |
> ++-------------------------+-------------+-------------+-------+
> +| CNV Burst offload (DMA) | 32          | 16          | 0     |
> ++-------------------------+-------------+-------------+-------+
> +| Manual offload (DMA)    | 32          | 16          | 16    |
> ++-------------------------+-------------+-------------+-------+
> +
> +In the triggered-buffer path the driver unpacks the 16-bit result in software
> +before pushing to the buffer, so ``storagebits`` is 16.
> +
> +In the DMA offload paths the DMA engine writes 32-bit words directly into the
> +IIO DMA buffer:
> +
> +* **CNV Burst offload**: the SPI engine reads AVG_IN registers with a 2-byte
> +  address phase followed by a 2-byte data phase; the 16-bit result lands in
> +  the lower half of the 32-bit word (``shift=0``).
> +* **Manual offload**: each 32-bit SPI word carries the channel byte in the
> +  first byte; the 16-bit result is returned in the upper half of the 32-bit

I would expect the "first" byte to be in the "upper half" of the 32-bits as
well. This layout could be explained better.

Also, since extra data has to be read in this mode, does this affect the max
conversion rate?

> +  word (``shift=16``).
> +
> +The ``in_voltageN_type`` sysfs attribute reflects the active scan type.
> +
> +
> +Unimplemented features
> +======================
> +
> +* GPIO controller functionality of the GP pins
> +* Clamp status and overrange events
> +* Raw accumulator (ACC_IN) and accumulator status registers
> +* ADC_BUSY and overrun status interrupts


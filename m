Return-Path: <linux-pwm+bounces-8139-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNa2MfTXmWkSXAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8139-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 17:06:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722516D3AF
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 17:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B225D302410E
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2B2D593C;
	Sat, 21 Feb 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bRv6yOlb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCC1E5B7A
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771689965; cv=none; b=cyccdwHJ/CQ9qnb1zhKl83U980I6OTVmFxDyGFW7fV9UJkkftObXlcshBs2dfvpfyy9Lf6/X33V1QSQCYHAk53IAMvxpcKP40tVtS5uOB8Lbp5UmDliV0UoxtDgGEAEf8L6eOqe1Cgk+OuOT8mK8iqwh3FWIQnvba++BrFTYMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771689965; c=relaxed/simple;
	bh=gyb/9ZB5EnwrenCnbv8sUM5uff76SoJ37iBuO5Pm5+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICRYm15r2w1kVV9hNwf7UrDI+pnmxpGMjDfOoO9fAD69YkonCEIg32YVa1gySBp7rTLLT31dDfK1z1tOJ7I3d0CtYSOsFygU7dXWLLfIPP5gQAZjBEhOP4NM0YqOvXhsjNAKaJdczS2kvSQxD/QBQGWo4pWd5dW6Rhg3C7pBt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bRv6yOlb; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-463208653d6so1943669b6e.3
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 08:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771689961; x=1772294761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AGVcGIoD5Zg2avg7ODun32xVt8CH7Ifzx0KSdwGaSU=;
        b=bRv6yOlbFzbigUvub6HrdvOZxkvioWkzh/Uu5b9xRx6GEte2RvhXvAp/NHyZbnYAdc
         x6gYA53Xl6DdHG+eNlN34f92QN0QaKItcThyoonJzxYyF3INihR3UOKVPqkHE6hArkmM
         qWDYv9UEv4HK03xGDx9+u/Pkx8lG3bp1p7lNmu88oEY4OGLA9BfQ8cZraCViPkEY40aZ
         cmCo26mClEW35eEmPmsrv88zKicXGRCrmbIqBGKoUSlpnBjrFgQ7qc+24UyuRMHMIvcl
         m3G9wjjGUpweup4+bxgoMPfKaRkbsyCXj/04fh1f7/KMaVeHAZNoQC+3FCn6DgLHPLYH
         uZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771689961; x=1772294761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AGVcGIoD5Zg2avg7ODun32xVt8CH7Ifzx0KSdwGaSU=;
        b=rkhI95Ce8Xkype5YWvNRNO+BAumBCxcof15R/S7xisiqsDNj9+xKMQ7H+g+plpin0p
         CkwseCRksM2tKnOfKsuOxhuDsSdw8VzrrUj5Ky45C6chNULPq/BkSvBewlM068vUIFwK
         hzgYdz9oyVPF4hZHKnKvuZCQo9nUudb8kEUZ5+j4TxaN5QtBxucKLJ3v7W0wT0CZvkfO
         AHwgyDon+E2Hsh+j7nr4h2uakITLsUto9796PDb9fPsKdEOyey/GK6DUW2sJnudyuqlC
         oVqqq/Cip0DUegcs2NMknJ4M3UzCSuMrjDeAWck/9LL1uxK+jv0SABcWJ7Ne7zWPJEBE
         jruA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpeSCOm7n9ElL67RFGEFniKwwE+XMA6gciukpiXruxsI/ruueaCuNoPg5bqJSzwLZ9Cvd/KwoamI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4yDy46p0HaQ5jrSet03H8dTlufrG2xkiEq2a8aLFchkrPsXU
	9ugq01l8/qeBVSTYLp2nvdrLj9oEWRoMrYfVY2RQzxuNu4PETFqMALrnLT8/LB2cXt4=
X-Gm-Gg: AZuq6aK64P/kadGhvR1ap/mDrB4ss+PXouLrzTbD9lufbj9lAYClaKnIg4fqMa6GCMC
	+3l9EAx/AoXbUqP3ay/f4HwOF1E+G6Y3uDdsJ2xJwnLGsVEmO4GEopDH2wEGOKch0ncyWm5LwlU
	IoWvZzmJNrqJVDcDMUTiBQ7vxO2JpYxDmvbP9CyvPxNA7FjYeyft3UZVORyEnA04QWhKGqZdbbQ
	IkGl8hII0Ps84Ic0fdk76M3SEU3DRQ6YdGEZWN60bejou6GRBEb8vXoVfYQ6ayfIDPUB0foXIJv
	bC/53jwYlA1o62zLxXBXnN9Q66hoEJXEMOE1T4Qm0Ct3jGIJHn0RdNQ4VhdIYkU0uugnpvhuGSN
	cxq/AVJ0nrqmnUaW0PA84j2TZ+pAeYRIhDe4R+7jGZdiFnNZkRcF+UJW00q/JczaUcq/iiDFMVQ
	yxhBngeK5t/2eIUURyBPHLd0OhV1TH9WvFdo21fYabZddcIcB+fsZ/4jeHKe+7SehA8v3sBQ==
X-Received: by 2002:a05:6808:c1f7:b0:45c:80b7:4e11 with SMTP id 5614622812f47-4644635c09emr1947502b6e.45.1771689960760;
        Sat, 21 Feb 2026 08:06:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a91absm2777166fac.20.2026.02.21.08.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 08:06:00 -0800 (PST)
Message-ID: <fef41429-51d6-4084-a75e-a7b609b5f894@baylibre.com>
Date: Sat, 21 Feb 2026 10:05:59 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add binding for AD5706R
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-1-7253bbd74889@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260220-dev_ad5706r-v1-1-7253bbd74889@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8139-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:url,analog.com:email]
X-Rspamd-Queue-Id: 5722516D3AF
X-Rspamd-Action: no action

On 2/20/26 2:02 AM, Alexis Czezar Torreno wrote:
> Add device tree binding documentation for the Analog Devices
> AD5706R 4-channel 16-bit current output digital-to-analog converter.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dabaf2195a07d2c66d44f69ca60e32e6bc37cf55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5706r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5706R 4-Channel Current Output DAC
> +
> +maintainers:
> +  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> +
> +description: |
> +  The AD5706R is a 16-bit, 4-channel current output digital-to-analog
> +  converter with SPI interface.
> +
> +  The driver supports dynamic SPI clock rate management via an external
> +  clock generator (e.g., AXI CLKGEN) referenced by the 'clocks' property.
> +  This allows separate read and write SPI speeds to be configured at
> +  runtime.

Devicetree is for describing how it is wired up, not how the driver uses
it, so leave this part out.

> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ad5706r.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5706r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 100000000
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Reference clock for SPI clock rate management.

Based on the driver, it sounds like this clock is not connected
to this chip at all, but rather the SPI controller clock. So it
does not belong here.

> +
> +  clock-names:
> +    items:
> +      - const: spi_clk
> +
> +  pwms:
> +    maxItems: 1
> +
> +  pwm-names:
> +    items:
> +      - const: ad5706r_ldacb

Instead of giving it a name, we can just write it as:

pwms:
  items:
    - description: PWM connected to the LDAC/TGP/DCK pin.

The items: also limits it to exactly one item, so we don't need
maxItems:.

> +
> +  dac-resetb-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the active-low reset pin.

The datasheet just has a /RESET pin. Not sure where the "b" comes
from.

> +
> +  dac-shdn-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the active-high shutdown pin.

I didn't see a "shutdown" pin in the datasheet. Do you mean the
OUT_EN pin?

> +

We could also add an io-channel for reading back the MUX_OUT pin
from the ADC it is connected to.

> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency

Voltage supplies should be required.


> +  - clocks
> +  - clock-names
> +  - pwms
> +  - pwm-names
> +  - dac-resetb-gpios
> +  - dac-shdn-gpios

I would not expect any of these to be required. Reset could be hardwired if
there aren't enough GPIOs. And something other than a PWM could be connected
to the LDAC/TGP/DCK pin. 

The point of the bindings is to describe how the chip is wired up, and that
includes any way it could possibly be wired up, not just what is implemented
in the driver.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad5706r";
> +            reg = <0>;
> +            spi-max-frequency = <100000000>;
> +
> +            clocks = <&spi_clk>;
> +            clock-names = "spi_clk";
> +
> +            dac-resetb-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
> +            dac-shdn-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
> +
> +            pwms = <&axi_pwm_gen 0 0>;
> +            pwm-names = "ad5706r_ldacb";
> +        };
> +    };
> +...
> 



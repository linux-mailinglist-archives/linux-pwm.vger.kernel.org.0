Return-Path: <linux-pwm+bounces-3888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AE9B036E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D27A2866E0
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CF1632E5;
	Fri, 25 Oct 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5KzXkmy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B012064ED;
	Fri, 25 Oct 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861768; cv=none; b=Pa+WHFTsRSgAPCCBfMCPp2exLl5Phly67/eORuMEOy00kYOeHMS5nAx3uq4F37997YcaI/maDljIdKCMvQa6HMW5B815SJUay1Pp2oOEzX8PuHrO/SLLz9Ust/EOU54ok06bR2MzelJFW3uzXJ6cdqjlAW+NlG2jkL2D7nSKT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861768; c=relaxed/simple;
	bh=iruPTfJhguStmTgeSqzjK008LNO26Q1EhbrKZnWfO5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQpsRv8SQ3TJLmZ+hFZym09jrK8Uuz6zQyO3tLb500uX+8Yw56KuEkh+IPjdjIfoGaJQliG/ttMu/i0skfJIO78cW3TdVXqlg7M5WAiXiAaCYuJreNKaDpDASa5fyEEsh/+boSnLmIs7Sch23cN3zH2iSJ/MszCrpJLQsRy6C5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5KzXkmy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1396352f8f.2;
        Fri, 25 Oct 2024 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729861764; x=1730466564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c26PlBlidZY0SpQdGKISU/d9UF6uKLDjTrjaTRk06X8=;
        b=H5KzXkmys0MYuGxAQ0qFUdWC6YMSLkRIs7IGoENs/idc8Jaa83lIUVdOoppmPpO9g9
         BahybVEQN/rqnuKSp8El4+Op+rUggCRSqGQXzp428JNjotQbmsmJG97aXbPzKf3ZKJV8
         8tXceI0IzJL/hvXdjfkKtAfjTj7OI25YldNKHkh+FqW0fsNRKaVVK/Z68MF969ufIYO0
         xPjwT/HudCMA12fYzaN9Fm7iiUAvEvIgk26BNDAFdt+LMdat5d2A4HX/D7lEsb5xaVWc
         N0pCxbOyPqUkH+awTVVWS00AzZ7Sn6vrQvh015YG2jDwWue+Q4SWgkiQBZuQ+oFeCmx/
         NbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861764; x=1730466564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c26PlBlidZY0SpQdGKISU/d9UF6uKLDjTrjaTRk06X8=;
        b=jdxfD649GIIozLq75is52TxXKFSu6b0iscjPZJxGZ6LzFEXkxUAi8Nqtmsy318MiPN
         J8uEBemQXl2F/d+7SFPA9H7y9s4nU0RxYrF8WrA+6NDLT+NuBF6AvrwjfSw45Jc6QCqk
         CGH47U7f9kIx9K3iScxCR4ZbrhXsmym3UQJjlPfGwijILqdEKqGJ96fr//QSsoc6aTwv
         vnJOoSwiW8YYaLpV+4ujdlEi2uGpdzHFVo+z6swO67ZjOOG+Y6AU+vmlCIw6RlWLNrhx
         NXqnSgLPOfpNLfLg6kEobXeZ3qZF+rojyVgoY3QlFebWUobMK/jxdZnShbhJMFOXPkvL
         RBng==
X-Forwarded-Encrypted: i=1; AJvYcCUn/Th4acepvPVVyXJ26MAWLzx4WjbwbjYouOxDUiDuL/85HT/QRhAPavoTZK4kymUgOuagQ1pttk6P@vger.kernel.org, AJvYcCVDhpE2YBwyAvLzIAbx35m8KZaUJHduxBNIIiuqAH806X3yYwz1WndES3l+5lzhjTgCArPGujd07oVg@vger.kernel.org, AJvYcCWvFZvjcg3s4LQPxfzoauIviuVgJiOhQH5L5e9DdqqBv/EWFhNIi6tRIIK3rtU/hYkbbD+m/JOrGeaR@vger.kernel.org, AJvYcCWyhTPe4mJiAxeCmskfzhM2lIKba04DqGixo76DJ6r/+9R1P6SJAdxI7XCS7yVByuAmhwBarfZUovcUkqKs@vger.kernel.org, AJvYcCXirBPF97CJc63bxNA03E6m4fM75erh4eFrdgEX3UQMUYRXQKrBvB84YNSkpK6trPVxlZ4D0s5/ql3D@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWmuxAGJyA564VYQFqmAza3jGQiej2yVi03tAaW9bcHvJG2iI
	+NGPjRNM/Uflt78kkIEthXUXJdCWXeOf6hAN+EueFKZPUuVPXSPj
X-Google-Smtp-Source: AGHT+IHuU3Ti5wIkz1ZgZAWxjiwdCi+U98n8AOLJnMwdg+TPiHucopd9jcmf4hQ5ay4Y+EnR5nhQ6Q==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr6787601f8f.25.1729861763571;
        Fri, 25 Oct 2024 06:09:23 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4745sm1464428f8f.116.2024.10.25.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:09:23 -0700 (PDT)
Message-ID: <35e3a616b1cd0b66096795f247604bbe1aa8300d.camel@gmail.com>
Subject: Re: [PATCH RFC v4 09/15] spi: axi-spi-engine: implement offload
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 15:09:22 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-9-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-9-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Implement SPI offload support for the AXI SPI Engine. Currently, the
> hardware only supports triggering offload transfers with a hardware
> trigger so attempting to use an offload message in the regular SPI
> message queue will fail. Also, only allows streaming rx data to an
> external sink, so attempts to use a rx_buf in the offload message will
> fail.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes:
> * Adapted to changes in other patches in the series.
> * Moved trigger enable/disable to same function as offload
> =C2=A0 enable/disable.
>=20
> v3 changes:
> * Added clk and dma_chan getter callbacks.
> * Fixed some bugs.
>=20
> v2 changes:
>=20
> This patch has been reworked to accommodate the changes described in all
> of the other patches.
> ---
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 273 ++++++++++++++++++++++++++++=
++++++++++-
> =C2=A02 files changed, 268 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 50d04fa317b7..af3143ec5245 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -168,6 +168,7 @@ config SPI_AU1550
> =C2=A0config SPI_AXI_SPI_ENGINE
> =C2=A0	tristate "Analog Devices AXI SPI Engine controller"
> =C2=A0	depends on HAS_IOMEM
> +	select SPI_OFFLOAD
> =C2=A0	help
> =C2=A0	=C2=A0 This enables support for the Analog Devices AXI SPI Engine =
SPI
> controller.
> =C2=A0	=C2=A0 It is part of the SPI Engine framework that is used in some=
 Analog
> Devices
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-e=
ngine.c
> index 2d24d762b5bd..1710847d81a1 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -2,11 +2,14 @@
> =C2=A0/*
> =C2=A0 * SPI-Engine SPI controller driver
> =C2=A0 * Copyright 2015 Analog Devices Inc.
> + * Copyright 2024 BayLibre, SAS
> =C2=A0 *=C2=A0 Author: Lars-Peter Clausen <lars@metafoo.de>
> =C2=A0 */
> =C2=A0
> +#include <linux/bitops.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/completion.h>
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/fpga/adi-axi-common.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/io.h>
> @@ -14,8 +17,10 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/overflow.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/spi/spi-offload.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0

...

> +#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
> =C2=A0#define SPI_ENGINE_REG_RESET			0x40
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_INT_ENABLE		0x80
> @@ -23,6 +28,7 @@
> =C2=A0#define SPI_ENGINE_REG_INT_SOURCE		0x88
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_SYNC_ID			0xc0
> +#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
> =C2=A0#define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
> @@ -33,10 +39,24 @@
> =C2=A0#define SPI_ENGINE_REG_SDI_DATA_FIFO		0xe8
> =C2=A0#define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
> =C2=A0
> +#define SPI_ENGINE_MAX_NUM_OFFLOADS		32
> +
> +#define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_RESET(x)		(0x108 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(x)	(0x110 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(x)	(0x114 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +
> +#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO	GENMASK(15, 8)
> +#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD	GENMASK(7, 0)
> +
> =C2=A0#define SPI_ENGINE_INT_CMD_ALMOST_EMPTY		BIT(0)
> =C2=A0#define SPI_ENGINE_INT_SDO_ALMOST_EMPTY		BIT(1)
> =C2=A0#define SPI_ENGINE_INT_SDI_ALMOST_FULL		BIT(2)
> =C2=A0#define SPI_ENGINE_INT_SYNC			BIT(3)
> +#define SPI_ENGINE_INT_OFFLOAD_SYNC		BIT(4)
> +
> +#define SPI_ENGINE_OFFLOAD_CTRL_ENABLE		BIT(0)
> =C2=A0
> =C2=A0#define SPI_ENGINE_CONFIG_CPHA			BIT(0)
> =C2=A0#define SPI_ENGINE_CONFIG_CPOL			BIT(1)
> @@ -78,6 +98,14 @@
> =C2=A0#define SPI_ENGINE_CMD_CS_INV(flags) \
> =C2=A0	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
> =C2=A0
> +/* default sizes - can be changed when SPI Engine firmware is compiled *=
/
> +#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
> +#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
> +
> +#define SPI_ENGINE_OFFLOAD_CAPS (SPI_OFFLOAD_CAP_TRIGGER | \
> +				 SPI_OFFLOAD_CAP_TX_STATIC_DATA | \
> +				 SPI_OFFLOAD_CAP_RX_STREAM_DMA)
> +
> =C2=A0struct spi_engine_program {
> =C2=A0	unsigned int length;
> =C2=A0	uint16_t instructions[] __counted_by(length);
> @@ -105,6 +133,16 @@ struct spi_engine_message_state {
> =C2=A0	uint8_t *rx_buf;
> =C2=A0};
> =C2=A0
> +enum {
> +	SPI_ENGINE_OFFLOAD_FLAG_PREPARED,
> +};
> +
> +struct spi_engine_offload {
> +	struct spi_engine *spi_engine;
> +	unsigned long flags;
> +	unsigned int offload_num;
> +};
> +
> =C2=A0struct spi_engine {
> =C2=A0	struct clk *clk;
> =C2=A0	struct clk *ref_clk;
> @@ -117,6 +155,11 @@ struct spi_engine {
> =C2=A0	unsigned int int_enable;
> =C2=A0	/* shadows hardware CS inversion flag state */
> =C2=A0	u8 cs_inv;
> +
> +	unsigned int offload_ctrl_mem_size;
> +	unsigned int offload_sdo_mem_size;
> +	struct spi_offload *offloads;
> +	unsigned int num_offloads;
> =C2=A0};
> =C2=A0
> =C2=A0static void spi_engine_program_add_cmd(struct spi_engine_program *p=
,
> @@ -164,7 +207,7 @@ static void spi_engine_gen_xfer(struct spi_engine_pro=
gram *p,
> bool dry,
> =C2=A0
> =C2=A0		if (xfer->tx_buf)
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_WRITE;
> -		if (xfer->rx_buf)
> +		if (xfer->rx_buf || (xfer->offload_flags &
> SPI_OFFLOAD_XFER_RX_STREAM))
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_READ;
> =C2=A0
> =C2=A0		spi_engine_program_add_cmd(p, dry,
> @@ -220,16 +263,24 @@ static void spi_engine_gen_cs(struct spi_engine_pro=
gram *p,
> bool dry,
> =C2=A0 *
> =C2=A0 * NB: This is separate from spi_engine_compile_message() because t=
he latter
> =C2=A0 * is called twice and would otherwise result in double-evaluation.
> + *
> + * Returns 0 on success, -EINVAL on failure.
> =C2=A0 */
> -static void spi_engine_precompile_message(struct spi_message *msg)
> +static int spi_engine_precompile_message(struct spi_message *msg)
> =C2=A0{
> =C2=A0	unsigned int clk_div, max_hz =3D msg->spi->controller->max_speed_h=
z;
> =C2=A0	struct spi_transfer *xfer;
> =C2=A0
> =C2=A0	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		/* If we have an offload transfer, we can't rx to buffer */
> +		if (msg->offload && xfer->rx_buf)
> +			return -EINVAL;
> +
> =C2=A0		clk_div =3D DIV_ROUND_UP(max_hz, xfer->speed_hz);
> =C2=A0		xfer->effective_speed_hz =3D max_hz / min(clk_div, 256U);
> =C2=A0	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static void spi_engine_compile_message(struct spi_message *msg, boo=
l dry,
> @@ -544,11 +595,94 @@ static irqreturn_t spi_engine_irq(int irq, void *de=
vid)
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> +static int spi_engine_offload_prepare(struct spi_message *msg)
> +{
> +	struct spi_controller *host =3D msg->spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_program *p =3D msg->opt_state;
> +	struct spi_engine_offload *priv =3D msg->offload->priv;
> +	struct spi_transfer *xfer;
> +	void __iomem *cmd_addr;
> +	void __iomem *sdo_addr;
> +	size_t tx_word_count =3D 0;
> +	unsigned int i;
> +
> +	if (p->length > spi_engine->offload_ctrl_mem_size)
> +		return -EINVAL;
> +
> +	/* count total number of tx words in message */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->tx_buf)
> +			continue;
> +
> +		if (xfer->bits_per_word <=3D 8)
> +			tx_word_count +=3D xfer->len;
> +		else if (xfer->bits_per_word <=3D 16)
> +			tx_word_count +=3D xfer->len / 2;
> +		else
> +			tx_word_count +=3D xfer->len / 4;
> +	}
> +
> +	if (tx_word_count > spi_engine->offload_sdo_mem_size)
> +		return -EINVAL;
> +
> +	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flag=
s))
> +		return -EBUSY;
> +

This is odd. Any special reason for using this with aquire - release semant=
ics? Can
optimize() and unoptimize() run concurrently? Because if they can this does=
 not give
us mutual exclusion and we really need to do what we're doing with kind of =
stuff :)

- Nuno S=C3=A1




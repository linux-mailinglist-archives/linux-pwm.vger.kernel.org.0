Return-Path: <linux-pwm+bounces-4364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182B9F4A27
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB03F167C43
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5351EF096;
	Tue, 17 Dec 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1LJb2QP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2B442F;
	Tue, 17 Dec 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435828; cv=none; b=LLicgsBiulYkIBWTFh/7d9rPS7yXZnIFGXGK2ckAKfBh91zR4ERZEF5qUjadem4tsxvNZVJ3OiOPxVLAyXFCU4H75pE6OKs6yP0xrT5IhXuDA0kx5iuykt3KGo5TZ8wiZg9JX9vxel5ZbgnSpPmp6dIvpO87Bn0ChzxbWO/fVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435828; c=relaxed/simple;
	bh=tlAMy5Z3vsGSUZZm1HeaoToi3waG7j4eJ6dPA7I7ylk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W82YsQd49yNsynWMgPTIjEMpCf4XP5B+5vfcdcg5qvx62KuJpG/TE+tEGQMR8uD8/7f3sd2bpHScdViTqU0z5PDPQ/k+tiHC/+BVlJ796D5STp6DNT6qvix3OISsJ34nUV2WY0q0nBeI5McEVHXrepahgJj6u7+sPhSQvM1hrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1LJb2QP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so703634366b.0;
        Tue, 17 Dec 2024 03:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734435824; x=1735040624; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPNPhT5SjkEQ5oK5dYppEKu2o/ntv6SXcthZev2Fz6U=;
        b=d1LJb2QPg0J7iLiIroByEETRAQu+UEynaOg7p/2dUpTZG4IX6AgpgYXAw5Ljgrbhy/
         hv8cv82InoNe4+PCptz2CgNDn47j7Iks7J5ZToV1q9lfTnbW6Dc6S0iEELZtdRSL/iBR
         zyWYcOgo9KLKsmPzFyV3WrSE82YkCQz69y4OEE4aspqgXaCGlX/cknpL/iMLU+IA3Rkn
         +NGsxusRpBBPnoPMV+7P5IoZnGFwChxcxU+0+e2/M/P3c/TyV7f2/6ZV35phaEZ8t5y4
         Ki5cWkqDeDWUQE3eTyZ4kxpLg2uMwp3ILkolYLInurOLhzFxX8eHD9JqcpzRQJatQyeh
         QMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435824; x=1735040624;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPNPhT5SjkEQ5oK5dYppEKu2o/ntv6SXcthZev2Fz6U=;
        b=VjCh/J2f0B2CddfpRlzqyuQWeY9h1u4j+r6CDZjjgmoyMfGgn5NMpEpwS/QBwkz2Ld
         UTTxo16pdcw75CX4PM1BQU7Jv1TJ0d5D1SrEktxlX5T6G+YT4yWc+2JPx7fTSbrhIisr
         ksPH9QnJzGNfBCfl19UUsiF6EsRAN66HAXxtqxCpD82/FHZzfaM4Pu8qoryZcHNgXkk2
         LU9a/YXH1IKWZ6KkJnu7BbSnj3hat6zicYP5OOhyK1ppeD4CGWVAUijz8j/uEOExMdcH
         sLnMKuKGgbehajPhPmB8Y186C50n2v1nLAmkf7X+vS2Y7B66H7BP5k2MYP9HIGvQEjJy
         K0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0b+zMwrrbqlZ4oIcWCCVva8BmrWg3Upt2vNfo5RB2reM93Hx9h5Tr+x0CHCJW26Khuz9zC0932SjQ@vger.kernel.org, AJvYcCV1aXQVR3vFxZPmD4jMey08ztGsuCBXXSLBApDjj56R7Z5/4kVM+Mi21hACVwz2oia9LZkWHei0sZv2/3zD@vger.kernel.org, AJvYcCVAdGV5pa03wDKGZTwZ3jcLeZNJzHr9MhE7ryd5iOryCESqET/3WIOS+rI4ierb9/kqzv+nen2nrNlu@vger.kernel.org, AJvYcCWRKzhcwpZ1t7CHuKBMHRz1waMsLHJeLc97S7B5OPxmTvhtcpMnMh0E5gxznnEGB2K7Lt8ciZ1ijfNS@vger.kernel.org, AJvYcCX85rEp6Ng0UOSNHQRO/ezSX9uzwSBrdVFxVSqkt6ioFpfUYtWLSuNdJ0pxUUB12TrUhLqxDbEgM9qR@vger.kernel.org
X-Gm-Message-State: AOJu0YxQL8+MB2MTaJ12mbzXL5sBRVyrq4Yu4OkHuBS08kqsuPdv+iyH
	v5kiFQ8rMjGTbqdtPuTKFO8f+1ipZX4ri5SRC4jal++t00vr1CRIe+jqoPinreU=
X-Gm-Gg: ASbGnctYMVjKkSfr1/hh1QqYICEonEwS1/W3xc1XgVOXb3Q8DvlpXEv19Xc1wkzfG3B
	Pj/nLM6GU+mq0yPhhcUR8t/g0ufGjm50XP31xM+kaUUYHgsWVqnUjeIir2gQsO/Q4y5rRK+BTYy
	+3kQj5Is7ppCTPNBClKvp2leqRHFJJy1qPynsCTOzn2rWMy8596zCIYPF05VbzpV8uu1XJnQXM5
	dmWoxaqRWgl1b/54jIVc9UlRnk2/Nsl1wi6lQzozVsEHEnpWctD1asxphNSYN/b75t1mkzCDqkn
	GXYJ9tytBCcm9OVNVdszLmXQB3JA6K7PI6/EsT043Rd7VMYd+qJZ8OHVXEkCcxLrH76etNq77pY
	60toYTj3zlC7+Vw==
X-Google-Smtp-Source: AGHT+IGlc3kfmNMtXizYMH0oSMNI3w1VNrM9LAvNmRcjrWwKHil/bXg7vTghWugMD/SaTgJpCjT9vQ==
X-Received: by 2002:a05:6402:13d2:b0:5d3:f55f:8349 with SMTP id 4fb4d7f45d1cf-5d63c407778mr34225793a12.33.1734435823914;
        Tue, 17 Dec 2024 03:43:43 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25cd8sm4179999a12.59.2024.12.17.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:43:43 -0800 (PST)
Message-ID: <8bd618525ee780ffc5b854db0226fc8d56b95366.camel@gmail.com>
Subject: Re: [PATCH v6 07/17] spi: axi-spi-engine: implement offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Tue, 17 Dec 2024 12:48:14 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-7-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-7-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
> Implement SPI offload support for the AXI SPI Engine. Currently, the
> hardware only supports triggering offload transfers with a hardware
> trigger so attempting to use an offload message in the regular SPI
> message queue will fail. Also, only allows streaming rx data to an
> external sink, so attempts to use a rx_buf in the offload message will
> fail.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes:
> * Update for split spi/offload headers.
>=20
> v5 changes:
> * Set offload capability flags based on DT properties.
> * Add support for TX DMA since the hardware supports that now.
> * Update for changes in other patches in the series.
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
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 314
> ++++++++++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 308 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index
> 2cfc14be869790f5226130428bb7cb40aadfb031..f496ab127ef011d092f66063e057727=
25ab8
> 9771 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -179,6 +179,7 @@ config SPI_AU1550
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
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index
> 7c252126b33ea83fe6a6e80c6cb87499243069f5..dd6077d3ff7b8d29b0ca2e803a5930c=
4cedf
> 2e93 100644
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
> @@ -14,9 +17,11 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/overflow.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/spi/offload/provider.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <trace/events/spi.h>
> =C2=A0
> +#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
> =C2=A0#define SPI_ENGINE_REG_RESET			0x40
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_INT_ENABLE		0x80
> @@ -24,6 +29,7 @@
> =C2=A0#define SPI_ENGINE_REG_INT_SOURCE		0x88
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_SYNC_ID			0xc0
> +#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
> =C2=A0#define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
> @@ -34,10 +40,24 @@
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
> @@ -79,6 +99,10 @@
> =C2=A0#define SPI_ENGINE_CMD_CS_INV(flags) \
> =C2=A0	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
> =C2=A0
> +/* default sizes - can be changed when SPI Engine firmware is compiled *=
/
> +#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
> +#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
> +
> =C2=A0struct spi_engine_program {
> =C2=A0	unsigned int length;
> =C2=A0	uint16_t instructions[] __counted_by(length);
> @@ -106,6 +130,17 @@ struct spi_engine_message_state {
> =C2=A0	uint8_t *rx_buf;
> =C2=A0};
> =C2=A0
> +enum {
> +	SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED,
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
> @@ -118,6 +153,11 @@ struct spi_engine {
> =C2=A0	unsigned int int_enable;
> =C2=A0	/* shadows hardware CS inversion flag state */
> =C2=A0	u8 cs_inv;
> +
> +	unsigned int offload_ctrl_mem_size;
> +	unsigned int offload_sdo_mem_size;
> +	struct spi_offload *offload;
> +	u32 offload_caps;
> =C2=A0};
> =C2=A0
> =C2=A0static void spi_engine_program_add_cmd(struct spi_engine_program *p=
,
> @@ -163,9 +203,9 @@ static void spi_engine_gen_xfer(struct spi_engine_pro=
gram
> *p, bool dry,
> =C2=A0		unsigned int n =3D min(len, 256U);
> =C2=A0		unsigned int flags =3D 0;
> =C2=A0
> -		if (xfer->tx_buf)
> +		if (xfer->tx_buf || (xfer->offload_flags &
> SPI_OFFLOAD_XFER_TX_STREAM))
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_WRITE;
> -		if (xfer->rx_buf)
> +		if (xfer->rx_buf || (xfer->offload_flags &
> SPI_OFFLOAD_XFER_RX_STREAM))
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_READ;
> =C2=A0
> =C2=A0		spi_engine_program_add_cmd(p, dry,
> @@ -217,16 +257,24 @@ static void spi_engine_gen_cs(struct spi_engine_pro=
gram
> *p, bool dry,
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
> @@ -521,11 +569,105 @@ static irqreturn_t spi_engine_irq(int irq, void *d=
evid)
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
> +		/* no support for reading to rx_buf */
> +		if (xfer->rx_buf)
> +			return -EINVAL;
> +
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
> +	if (tx_word_count && !(spi_engine->offload_caps &
> SPI_OFFLOAD_CAP_TX_STATIC_DATA))
> +		return -EINVAL;
> +
> +	if (tx_word_count > spi_engine->offload_sdo_mem_size)
> +		return -EINVAL;
> +
> +	/*
> +	 * This protects against calling spi_optimize_message() with an
> offload
> +	 * that has already been prepared with a different message.
> +	 */
> +	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv-
> >flags))
> +		return -EBUSY;
> +
> +	cmd_addr =3D spi_engine->base +
> +		=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv->offload_num);
> +	sdo_addr =3D spi_engine->base +
> +		=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(priv->offload_num);
> +
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->tx_buf)
> +			continue;
> +
> +		if (xfer->bits_per_word <=3D 8) {
> +			const u8 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		} else if (xfer->bits_per_word <=3D 16) {
> +			const u16 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len / 2; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		} else {
> +			const u32 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len / 4; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		}
> +	}
> +
> +	for (i =3D 0; i < p->length; i++)
> +		writel_relaxed(p->instructions[i], cmd_addr);
> +
> +	return 0;
> +}
> +
> +static void spi_engine_offload_unprepare(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +	struct spi_engine *spi_engine =3D priv->spi_engine;
> +
> +	writel_relaxed(1, spi_engine->base +
> +			=C2=A0 SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
> +	writel_relaxed(0, spi_engine->base +
> +			=C2=A0 SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
> +
> +	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags);
> +}
> +
> =C2=A0static int spi_engine_optimize_message(struct spi_message *msg)
> =C2=A0{
> =C2=A0	struct spi_engine_program p_dry, *p;
> +	int ret;
> =C2=A0
> -	spi_engine_precompile_message(msg);
> +	ret =3D spi_engine_precompile_message(msg);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	p_dry.length =3D 0;
> =C2=A0	spi_engine_compile_message(msg, true, &p_dry);
> @@ -537,20 +679,61 @@ static int spi_engine_optimize_message(struct
> spi_message *msg)
> =C2=A0	spi_engine_compile_message(msg, false, p);
> =C2=A0
> =C2=A0	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
> -
> 						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
> +		msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
> =C2=A0
> =C2=A0	msg->opt_state =3D p;
> =C2=A0
> +	if (msg->offload) {
> +		ret =3D spi_engine_offload_prepare(msg);
> +		if (ret) {
> +			msg->opt_state =3D NULL;
> +			kfree(p);
> +			return ret;
> +		}
> +	}
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int spi_engine_unoptimize_message(struct spi_message *msg)
> =C2=A0{
> +	if (msg->offload)
> +		spi_engine_offload_unprepare(msg->offload);
> +
> =C2=A0	kfree(msg->opt_state);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static struct spi_offload
> +*spi_engine_get_offload(struct spi_device *spi,
> +			const struct spi_offload_config *config)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +
> +	if (!spi_engine->offload)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (config->capability_flags & ~spi_engine->offload_caps)
> +		return ERR_PTR(-EINVAL);
> +
> +	priv =3D spi_engine->offload->priv;
> +
> +	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv-
> >flags))
> +		return ERR_PTR(-EBUSY);
> +
> +	return spi_engine->offload;
> +}
> +
> +static void spi_engine_put_offload(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +
> +	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv->flags);
> +}
> +
> =C2=A0static int spi_engine_setup(struct spi_device *device)
> =C2=A0{
> =C2=A0	struct spi_controller *host =3D device->controller;
> @@ -583,6 +766,12 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	unsigned int int_enable =3D 0;
> =C2=A0	unsigned long flags;
> =C2=A0
> +	if (msg->offload) {
> +		dev_err(&host->dev, "Single transfer offload not
> supported\n");
> +		msg->status =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> =C2=A0	/* reinitialize message state for this transfer */
> =C2=A0	memset(st, 0, sizeof(*st));
> =C2=A0	st->cmd_buf =3D p->instructions;
> @@ -632,11 +821,68 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0			trace_spi_transfer_stop(msg, xfer);
> =C2=A0	}
> =C2=A0
> +out:
> =C2=A0	spi_finalize_current_message(host);
> =C2=A0
> =C2=A0	return msg->status;
> =C2=A0}
> =C2=A0
> +static int spi_engine_trigger_enable(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +	struct spi_engine *spi_engine =3D priv->spi_engine;
> +	unsigned int reg;
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
> +	reg |=3D SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
> +	return 0;
> +}
> +
> +static void spi_engine_trigger_disable(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +	struct spi_engine *spi_engine =3D priv->spi_engine;
> +	unsigned int reg;
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
> +	reg &=3D ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
> +}
> +
> +static struct dma_chan
> +*spi_engine_tx_stream_request_dma_chan(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +	char name[16];
> +
> +	snprintf(name, sizeof(name), "offload%u-tx", priv->offload_num);
> +
> +	return dma_request_chan(offload->provider_dev, name);
> +}
> +
> +static struct dma_chan
> +*spi_engine_rx_stream_request_dma_chan(struct spi_offload *offload)
> +{
> +	struct spi_engine_offload *priv =3D offload->priv;
> +	char name[16];
> +
> +	snprintf(name, sizeof(name), "offload%u-rx", priv->offload_num);
> +
> +	return dma_request_chan(offload->provider_dev, name);
> +}
> +
> +static const struct spi_offload_ops spi_engine_offload_ops =3D {
> +	.trigger_enable =3D spi_engine_trigger_enable,
> +	.trigger_disable =3D spi_engine_trigger_disable,
> +	.tx_stream_request_dma_chan =3D spi_engine_tx_stream_request_dma_chan,
> +	.rx_stream_request_dma_chan =3D spi_engine_rx_stream_request_dma_chan,
> +};
> +
> =C2=A0static void spi_engine_release_hw(void *p)
> =C2=A0{
> =C2=A0	struct spi_engine *spi_engine =3D p;
> @@ -651,8 +897,7 @@ static int spi_engine_probe(struct platform_device *p=
dev)
> =C2=A0	struct spi_engine *spi_engine;
> =C2=A0	struct spi_controller *host;
> =C2=A0	unsigned int version;
> -	int irq;
> -	int ret;
> +	int irq, ret;
> =C2=A0
> =C2=A0	irq =3D platform_get_irq(pdev, 0);
> =C2=A0	if (irq < 0)
> @@ -667,6 +912,46 @@ static int spi_engine_probe(struct platform_device *=
pdev)
> =C2=A0	spin_lock_init(&spi_engine->lock);
> =C2=A0	init_completion(&spi_engine->msg_complete);
> =C2=A0
> +	/*
> +	 * REVISIT: for now, all SPI Engines only have one offload. In the
> +	 * future, this should be read from a memory mapped register to
> +	 * determine the number of offloads enabled at HDL compile time. For
> +	 * now, we can tell if an offload is present if there is a trigger
> +	 * source wired up to it.
> +	 */
> +	if (device_property_present(&pdev->dev, "trigger-sources")) {
> +		struct spi_engine_offload *priv;
> +
> +		spi_engine->offload =3D
> +			devm_spi_offload_alloc(&pdev->dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct
> spi_engine_offload));
> +		if (IS_ERR(spi_engine->offload))
> +			return PTR_ERR(spi_engine->offload);
> +
> +		priv =3D spi_engine->offload->priv;
> +		priv->spi_engine =3D spi_engine;
> +		priv->offload_num =3D 0;
> +
> +		spi_engine->offload->ops =3D &spi_engine_offload_ops;
> +		spi_engine->offload_caps =3D SPI_OFFLOAD_CAP_TRIGGER;
> +
> +		if (device_property_match_string(&pdev->dev, "dma-names",
> "offload0-rx") >=3D 0) {
> +			spi_engine->offload_caps |=3D
> SPI_OFFLOAD_CAP_RX_STREAM_DMA;
> +			spi_engine->offload->xfer_flags |=3D
> SPI_OFFLOAD_XFER_RX_STREAM;
> +		}
> +
> +		if (device_property_match_string(&pdev->dev, "dma-names",
> "offload0-tx") >=3D 0) {
> +			spi_engine->offload_caps |=3D
> SPI_OFFLOAD_CAP_TX_STREAM_DMA;
> +			spi_engine->offload->xfer_flags |=3D
> SPI_OFFLOAD_XFER_TX_STREAM;
> +		} else {
> +			/*
> +			 * HDL compile option to enable TX DMA stream also
> disables
> +			 * the SDO memory, so can't do both at the same time.
> +			 */
> +			spi_engine->offload_caps |=3D
> SPI_OFFLOAD_CAP_TX_STATIC_DATA;
> +		}
> +	}
> +
> =C2=A0	spi_engine->clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk")=
;
> =C2=A0	if (IS_ERR(spi_engine->clk))
> =C2=A0		return PTR_ERR(spi_engine->clk);
> @@ -688,6 +973,19 @@ static int spi_engine_probe(struct platform_device *=
pdev)
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> +	if (ADI_AXI_PCORE_VER_MINOR(version) >=3D 1) {
> +		unsigned int sizes =3D readl(spi_engine->base +
> +				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
> +
> +		spi_engine->offload_ctrl_mem_size =3D 1 <<
> +			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD,
> sizes);
> +		spi_engine->offload_sdo_mem_size =3D 1 <<
> +			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO,
> sizes);
> +	} else {
> +		spi_engine->offload_ctrl_mem_size =3D
> SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE;
> +		spi_engine->offload_sdo_mem_size =3D
> SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE;
> +	}
> +
> =C2=A0	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
> =C2=A0	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING=
);
> =C2=A0	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE)=
;
> @@ -709,6 +1007,8 @@ static int spi_engine_probe(struct platform_device *=
pdev)
> =C2=A0	host->transfer_one_message =3D spi_engine_transfer_one_message;
> =C2=A0	host->optimize_message =3D spi_engine_optimize_message;
> =C2=A0	host->unoptimize_message =3D spi_engine_unoptimize_message;
> +	host->get_offload =3D spi_engine_get_offload;
> +	host->put_offload =3D spi_engine_put_offload;
> =C2=A0	host->num_chipselect =3D 8;
> =C2=A0
> =C2=A0	/* Some features depend of the IP core version. */
>=20



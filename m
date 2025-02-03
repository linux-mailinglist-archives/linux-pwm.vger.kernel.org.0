Return-Path: <linux-pwm+bounces-4760-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC0A25E93
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF297A03F8
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A120896D;
	Mon,  3 Feb 2025 15:25:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87E204C04;
	Mon,  3 Feb 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596324; cv=none; b=o5tEo6osVfiQoijFNi0l3wsA2B3+8m846W7VA6m7WKFj9TgRrAisKaHqQISPHrBUv2JOHTzLzEGYaQaIvRZQhbVP9hAHA9fuV74d3Sj02Py7l7nZS7LkDU94ClwojTQs+LTrdarHkk9E0rpYhqLpIG1N1caANiNLklCNsIrgFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596324; c=relaxed/simple;
	bh=LHx2jv3DzF/zEliW+d9kmeskkTFn+kWCn6Wl6XkI4Yg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yqd1aSN7rWvxbuecKCIrGNTRVJwNZhf5YAH05BQOsaVmEwcLZsCM1PiEc5BeFSeUzykl4GrNRrXZEKz+/c0evtOkXihdPaw4397W+kUfGI8yuJNLklTV8CbZQvRGIOl8vqgwDiDz3lBR849N9SY7Replh/XxG3rDOp3bAuQlxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymqy25m0Yz6D8xn;
	Mon,  3 Feb 2025 23:23:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AE733140B63;
	Mon,  3 Feb 2025 23:25:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 16:25:19 +0100
Date: Mon, 3 Feb 2025 15:25:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC: David Lechner <dlechner@baylibre.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, "Angelo
 Dureghello" <adureghello@baylibre.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: set data format
Message-ID: <20250203152517.000028ca@huawei.com>
In-Reply-To: <CY4PR03MB33993EE62F4E1B3939F213B29BF52@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
	<20250127105726.6314-6-antoniu.miclaus@analog.com>
	<08d8e97d-752d-4fa7-95f0-d828ef80f7b8@baylibre.com>
	<CY4PR03MB33993EE62F4E1B3939F213B29BF52@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Feb 2025 11:02:58 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

>  
> > On 1/27/25 4:57 AM, Antoniu Miclaus wrote:  
> > > Add support for selecting the data format within the AXI ADC ip.
> > >
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > no changes in v11.
> > >  drivers/iio/adc/adi-axi-adc.c | 46  
> > +++++++++++++++++++++++++++++++++++  
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> > > index d2e1dc63775c..3c213ca5ff8e 100644
> > > --- a/drivers/iio/adc/adi-axi-adc.c
> > > +++ b/drivers/iio/adc/adi-axi-adc.c
> > > @@ -45,6 +45,12 @@
> > >  #define ADI_AXI_ADC_REG_CTRL			0x0044
> > >  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> > >
> > > +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> > > +#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
> > > +#define   AD485X_PACKET_FORMAT_20BIT		0x0
> > > +#define   AD485X_PACKET_FORMAT_24BIT		0x1
> > > +#define   AD485X_PACKET_FORMAT_32BIT		0x2
> > > +
> > >  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
> > >  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
> > >
> > > @@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct  
> > iio_backend *back,  
> > >  	return 0;
> > >  }
> > >
> > > +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
> > > +{
> > > +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> > > +	unsigned int val;
> > > +
> > > +	switch (size) {
> > > +	/*
> > > +	 * There are two different variants of the AXI AD485X IP block, a 16-bit
> > > +	 * and a 20-bit variant.
> > > +	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding  
> > also to  
> > > +	 * the 16-bit variant of the IP block.
> > > +	 */
> > > +	case 16:
> > > +	case 20:
> > > +		val = AD485X_PACKET_FORMAT_20BIT;
> > > +		break;
> > > +	case 24:
> > > +		val = AD485X_PACKET_FORMAT_24BIT;
> > > +		break;
> > > +	/*
> > > +	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to  
> > the 20-bit  
> > > +	 * variant of the IP block. Setting this value properly is ensured by
> > > +	 * the upper layers of the drivers calling the axi-adc functions.
> > > +	 * Also, for 16-bit IP block, the 0x2  
> > (AD485X_PACKET_FORMAT_32BIT)  
> > > +	 * value is handled as maximum size available which is 24-bit for this
> > > +	 * configuration.
> > > +	 */
> > > +	case 32:
> > > +		val = AD485X_PACKET_FORMAT_32BIT;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return regmap_update_bits(st->regmap,  
> > ADI_AXI_ADC_REG_CNTRL_3,  
> > > +				  AD485X_CNTRL_3_PACKET_FORMAT_MSK,
> > > +  
> > FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));  
> > > +}
> > > +
> > >  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
> > >  						 struct iio_dev *indio_dev)
> > >  {
> > > @@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_ops  
> > = {  
> > >  	.test_pattern_set = axi_adc_test_pattern_set,
> > >  	.chan_status = axi_adc_chan_status,
> > >  	.interface_type_get = axi_adc_interface_type_get,
> > > +	.data_size_set = axi_adc_data_size_set,
> > >  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
> > >  	.debugfs_print_chan_status =  
> > iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),  
> > >  };  
> > 
> > Why was [1] not addressed?
> > 
> > [1]: https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > iio/9c262f599fb9b42feac99cfb541723a0a6f50e6b.camel@gmail.com/__;!!A
> > 3Ni8CS0y2Y!6uVytAwWUCsEazOUTACecMQkbMuHBF95sbla50CbTUFkZkyxS
> > -S7jMOCczpoyKCjtAKvMOyrt0ukYwcXC_l5q60$  
> 
> Indeed it was not addressed. I remained with the impression that adding part prefix
> in the macro definitions was enough. I will add the compatible string support.
> Although I have a question in order to minimize the number of versions to be sent
> In the future. Should I add a separate patch for the compatible support (which
> will not add value independently) or should I include it in this patch which adds
> custom function for data format for the AD485x IP core?

Binding docs update needs to be a separate patch.

Also, we should probably only set axi_adc_data_size_set in iio_backend_ops for
that ID.  So you'll need to pick from two copies of adi_axi_adc_ops
which probably means two iio_backend_info structures.
That data_size_set callback should not be set for cases that don't use it
(so the generic IP if I understand this correctly).

Similar to that part of:
https://lore.kernel.org/all/20250129-wip-bl-ad7606_add_backend_sw_mode-v3-7-c3aec77c0ab7@baylibre.com/

Hmm. This is looking like a messy merge.

Angelo, Antoniu,

Please figure out between you an order to the series so who is going to have
to rebase.  If this one goes first, may be worth pulling part of
patch 6 from Angelo's set to introduce struct axi_adc_info with what
this patch needs (just the backend_info pointer and maybe version?)

Thanks,

Jonathan



Return-Path: <linux-pwm+bounces-6461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32DAE2A3B
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EE3165A8D
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946E14A62B;
	Sat, 21 Jun 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWAMRLP/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51817BD3;
	Sat, 21 Jun 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522617; cv=none; b=XYs51ah085erDclQK6LbhpBv/duzNnyNK5Mvrj4u1gs9NkjZ4yYIBjO1l4qTQr+mbBNhanVcoFhtvWvKR1Y8XAxnOkfBefn7K0+5JL1J5UzynbXt0U7tD50jdc6rSwM/JAfiTh9jZAzYokwMZ/zCJl8Dd9QVYCBQuKZSR2rUuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522617; c=relaxed/simple;
	bh=Qv21DpKuY5ulUd/lhpFtmQI0Y3I4JarC2uI/1WkzTHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhou0Xw0oFVbDblx6uVyprNu9OEAqamctkS4KJzKeXsMRMbegTF5xqtgGQ3c296RWGA66J2xiTkVl8Tq6hIANXjBiyFYTDaa06u7zM8BhhNIsaNpNRrPiXN2Jae29+34khR0bh0p3GCwXrKIyJaAqTkW2qB29NtvM62BkPemBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWAMRLP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AACC4CEE7;
	Sat, 21 Jun 2025 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750522617;
	bh=Qv21DpKuY5ulUd/lhpFtmQI0Y3I4JarC2uI/1WkzTHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWAMRLP/E9lB1GnDW9CuOx7pDPmUgG0AAYQDBx9az9cVjKiWC47nj1HZn7JvbKT+b
	 6U5PcNKUXrGyEX2vHTbnHdBhFVPcYz4VjGj4LnzlI9WuYU65InMOnnrTuzrggSuTqu
	 c0UpCjdB7LIB4DAf9N8k+movBQoBMYvlUUYLSeLjV8XlDfNSzjUdHUPd8P8GuWvnRi
	 TwEsOjwekxmWPk9fFBNhcFFIIZ2l18sGbASeqchc9FOTkZ9qEUdCQUJFmaSOtkAM9l
	 eQdjDB7NADDveq/efMaBOve171g0ioXBXagVCjAO5KnI36tHzDrQgwaoHIHyCG69Ke
	 fbXiXIFfT5GIA==
Date: Sat, 21 Jun 2025 17:16:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iio: adc: Add offload support for ad4052
Message-ID: <20250621171648.6f40904f@jic23-huawei>
In-Reply-To: <hdwuh3ouw4gzpbj7u7dtzaphdjonecls2xuu7p4nmi7wwrcmye@jhhhqvdlbuv3>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-6-cf1e44c516d4@analog.com>
	<20250614112022.24bf9212@jic23-huawei>
	<hdwuh3ouw4gzpbj7u7dtzaphdjonecls2xuu7p4nmi7wwrcmye@jhhhqvdlbuv3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 20:52:10 +0200
Jorge Marques <gastmaier@gmail.com> wrote:

> On Sat, Jun 14, 2025 at 11:20:22AM +0100, Jonathan Cameron wrote:
> > On Tue, 10 Jun 2025 09:34:39 +0200
> > Jorge Marques <jorge.marques@analog.com> wrote:
> >   
> > > Support SPI offload with appropriate FPGA firmware. Since the SPI-Engine
> > > offload module always sends 32-bit data to the DMA engine, the
> > > scantype.storagebytes is set to 32-bit and the SPI transfer length is
> > > based on the scantype.realbits. This combination allows to optimize the
> > > SPI to transfer only 2 or 3 bytes (depending on the granularity and
> > > mode), while the number of samples are computed correctly by tools on
> > > top of the iio scantype.
> > > 
> > > Signed-off-by: Jorge Marques <jorge.marques@analog.com>  
> > Minor comments inline.  I think they are all follow up from comments on
> > earlier patches that apply here as well.
> >   
> > > ---
> > >  drivers/iio/adc/ad4052.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 242 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> > > index 842f5972a1c58701addf5243e7b87da9c26c773f..7d32dc4701ddb0204b5505a650ce7caafc2cb5ed 100644
> > > --- a/drivers/iio/adc/ad4052.c
> > > +++ b/drivers/iio/adc/ad4052.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/err.h>
> > >  #include <linux/gpio/consumer.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/buffer-dmaengine.h>
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/interrupt.h>
> > > @@ -23,6 +25,8 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/spi/spi.h>
> > > +#include <linux/spi/offload/consumer.h>
> > > +#include <linux/spi/offload/provider.h>
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > >  #include <linux/units.h>
> > > @@ -111,6 +115,7 @@ enum ad4052_interrupt_en {
> > >  
> > >  struct ad4052_chip_info {
> > >  	const struct iio_chan_spec channels[1];
> > > +	const struct iio_chan_spec offload_channels[1];  
> > 
> > If there is only ever one of these drop the array.
> >   
> Hi Jonathan,
> 
> It is hard to predict if no other similar device will have only two
> channels. But I would say most drivers end-up having more channels.

Ok. I don't mind that much, but it does feel like planning for a future
that might or might not come.   Easy enough to refactor later.

> >   
> > >  
> > > +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> > > +				      struct iio_chan_spec const *chan)
> > > +{
> > > +	struct ad4052_state *st = iio_priv(indio_dev);
> > > +	const struct iio_scan_type *scan_type;
> > > +	struct spi_transfer *xfer = &st->offload_xfer;
> > > +
> > > +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> > > +	if (IS_ERR(scan_type))
> > > +		return PTR_ERR(scan_type);
> > > +
> > > +	xfer->bits_per_word = scan_type->realbits;
> > > +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> > > +	xfer->len = scan_type->realbits == 24 ? 4 : 2;  
> > 
> > Same question on length vs bits_per_word applies here as in the earlier
> > patch.
> >   
> To be able to optimize the SPI message, len must be a multiple of 16
> bits. To achieve maximum throughput, no extra bits (and therefore SCLK
> clock cycles) must be transferred during the SPI transfer. This is set
> by bits_per_word, 24-bits means 24 SCLK.

I got that intention, what I wasn't sure on was what the spi subsystem
would do with this case.

I checked the docs and this case is called out though only in the
spi_device docs for bits_per_word (not mentioned in the spi_transfer
docs) so fair enough.  Just seemed strange!
 
> 
> Finally, storagebits is the number of bits actually used to store the
> reading, and for the offload channel is the DMA width, always 32-bits.
> An abstraction to obtain the DMA width should be created, so the 32-bits
> value is not hard-coded into the driver, still, for this series, it is.
> 
Thanks

Jonathan




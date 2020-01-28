Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40614B18B
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2020 10:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgA1JKd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jan 2020 04:10:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgA1JKd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Jan 2020 04:10:33 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0892BE338C1271D8C824;
        Tue, 28 Jan 2020 09:10:31 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 09:10:14 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 09:10:13 +0000
Date:   Tue, 28 Jan 2020 09:10:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] iio: temperature: Add support for Azoteq
 IQS620AT temperature sensor
Message-ID: <20200128091001.00001e1d@Huawei.com>
In-Reply-To: <20200122032821.GA29969@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
        <1579228475-6681-6-git-send-email-jeff@labundy.com>
        <20200122032821.GA29969@labundy.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 22 Jan 2020 03:28:28 +0000
Jeff LaBundy <jeff@labundy.com> wrote:

> Hi Jonathan,
> 
> I just wanted to give a heads up that I'm making a couple of very minor
> changes to the lot of IIO patches in this series in response to changes
> to include/linux/mfd/iqs62x.h for v5, namely:
> 
> - Replaced iqs62x->map with iqs62x->regmap
> - Dropped #defines for platform_driver name and alias in favor of the
>   actual string names (e.g. IQS620_DRV_NAME_TEMP --> "iqs620at-temp")
> 
> For small changes like these, I plan to retain your Reviewed-by trailer
> when I send out v5 even though the file would have changed slightly. If
> you would prefer I let you re-review first, please let me know.

I'm fine with you keeping it.  Thanks for checking though.

Jonathan
> 
> On Thu, Jan 16, 2020 at 08:36:08PM -0600, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620AT temperature sensor,
> > capable of reporting its absolute die temperature.
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > Changes in v4:
> >   - None
> > 
> > Changes in v3:
> >   - Added Reviewed-by trailer
> > 
> > Changes in v2:
> >   - Moved the driver from hwmon to iio
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comments
> >   - Replaced 'error' with 'ret' throughout
> >   - Eliminated tabbed alignment of platform_driver struct members
> >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> > 
> >  drivers/iio/temperature/Kconfig         | 10 ++++
> >  drivers/iio/temperature/Makefile        |  1 +
> >  drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++++++
> >  3 files changed, 108 insertions(+)
> >  create mode 100644 drivers/iio/temperature/iqs620at-temp.c
> >   
> 
> Kind regards,
> Jeff LaBundy



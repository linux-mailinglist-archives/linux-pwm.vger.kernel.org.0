Return-Path: <linux-pwm+bounces-4201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E19E1C0F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 13:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB11E28162C
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA71E570D;
	Tue,  3 Dec 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PgY5nn9U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AE1E492D
	for <linux-pwm@vger.kernel.org>; Tue,  3 Dec 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228656; cv=none; b=GeFUW6PyxLx4/omxERlTv4WF6dUSe02N3aBUAO1LWpbr/lKeSyHzFTPEEbPnqDC3b23AhHN5cNIhDhBcqpOiDvvsws+zjpi2oz0Jj2lPsDUVIGdq3dwsaibeTjk9CEH8+4kidtd0ngxUJfUmUg2GPRKFrSVNQtUYp/0FIpZ7Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228656; c=relaxed/simple;
	bh=mCIHbMTp8TXOIpl1+nubIptrAHWq3pU6doVeMEipNVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0FvRf6BCbWJ9+AObBMf2GFq6YGYe9pU9VpHFHX3faqu7OvKK1CSMHtTn+jdv0h0LO0Y2Cqwa7TN/fR0QZecsaVdMQilmwPIAT6Abr70lt83//BZY85tELJhgCs4xxHt+oqt8fm2goqoShE7bUi1fIKl2A1z3DIOH7cG1cHQ/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PgY5nn9U; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733228654;
	bh=CgCScBX/+fgZ0roCuYsgonJhaxWB8rsl1yCC6V0WM+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=PgY5nn9UjaNQNnW4ZpJ9WuRQx6im5psJe58NOrhuMYaP81TCjCoqg7OOKUTCf/GiQ
	 U5NzWhh2P25K5ajpXMvRXYX0Q0QlkR8pgL3oTItbqVZutGKevLmlI66ZBGBcrDMdzZ
	 tMmlV2WZ2o8x16WpoGlJ/JnV1zI3oqt06fGl4I8/qI7wYj0KQ1QQr5n3xLSgizk9fw
	 TQ9xaKi2nZyOPqodk3YoZL2QcRqFeCLp3CsTqDDtllnMk1q4GHXKVq7SsECnBkg8jm
	 H9mCDktUr1zn+c+7ek7cGPeMoLhQxufGfyCDPYAJQXskQd4pXIE2C7c2QiBSj9B4RB
	 vRrMl0+rr+jVw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 675CEC8010E;
	Tue,  3 Dec 2024 12:23:51 +0000 (UTC)
Message-ID: <9d34bd6f-b120-428a-837b-5a5813e14618@icloud.com>
Date: Tue, 3 Dec 2024 20:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Jiri Slaby <jirislaby@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Andreas Larsson <andreas@gaisler.com>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Jens Axboe <axboe@kernel.dk>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pwm@vger.kernel.org, nvdimm@lists.linux.dev,
 linux1394-devel@lists.sourceforge.net, linux-serial@vger.kernel.org,
 linux-sound@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, linux-cxl@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
 <g32cigmktmj4egkq2tof27el2yss4liccfxgebkgqvkil32mlb@e3ta4ezv7y4m>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <g32cigmktmj4egkq2tof27el2yss4liccfxgebkgqvkil32mlb@e3ta4ezv7y4m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HfN3ugOwn0RD4lT0NgRrMbrQZDyUcr0J
X-Proofpoint-ORIG-GUID: HfN3ugOwn0RD4lT0NgRrMbrQZDyUcr0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_01,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=903 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412030107

On 2024/12/3 20:00, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 08:33:22AM +0800, Zijun Hu wrote:
>> This patch series is to constify the following API:
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> To :
>> struct device *device_find_child(struct device *dev, const void *data,
>> 				 device_match_t match);
>> typedef int (*device_match_t)(struct device *dev, const void *data);
> 
> This series isn't bisectible. With only the first two patches applied I
> hit:

yes. such patch series needs to be merge as atomic way.

Hi Greg,

is it possible to ONLY merge such patch series by atomic way into your
driver-core tree?

or squash such patch series into a single patch ?

various subsystem maintainers may not like squashing way.

> 
>   CC      drivers/pwm/core.o
> drivers/pwm/core.c: In function ‘pwm_unexport_child’:
> drivers/pwm/core.c:1292:55: error: passing argument 3 of ‘device_find_child’ from incompatible pointer type [-Wincompatible-pointer-types]
>  1292 |         pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
>       |                                                       ^~~~~~~~~~~~~~~~~~
>       |                                                       |
>       |                                                       int (*)(struct device *, void *)
> In file included from include/linux/acpi.h:14,
>                  from drivers/pwm/core.c:11:
> include/linux/device.h:1085:49: note: expected ‘device_match_t’ {aka ‘int (*)(struct device *, const void *)’} but argument is of type ‘int (*)(struct device *, void *)’
>  1085 |                                  device_match_t match);
>       |                                  ~~~~~~~~~~~~~~~^~~~~
> drivers/pwm/core.c: In function ‘pwm_class_get_state’:
> drivers/pwm/core.c:1386:55: error: passing argument 3 of ‘device_find_child’ from incompatible pointer type [-Wincompatible-pointer-types]
>  1386 |         pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
>       |                                                       ^~~~~~~~~~~~~~~~~~
>       |                                                       |
>       |                                                       int (*)(struct device *, void *)
> include/linux/device.h:1085:49: note: expected ‘device_match_t’ {aka ‘int (*)(struct device *, const void *)’} but argument is of type ‘int (*)(struct device *, void *)’
>  1085 |                                  device_match_t match);
>       |                                  ~~~~~~~~~~~~~~~^~~~~
> make[5]: *** [scripts/Makefile.build:194: drivers/pwm/core.o] Error 1
> make[4]: *** [scripts/Makefile.build:440: drivers/pwm] Error 2
> make[3]: *** [scripts/Makefile.build:440: drivers] Error 2
> make[2]: *** [Makefile:1989: .] Error 2
> make[1]: *** [Makefile:372: __build_one_by_one] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> Best regards
> Uwe



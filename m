Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54887A5915
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfIBORo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 10:17:44 -0400
Received: from vern.gendns.com ([98.142.107.122]:47558 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfIBORo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Sep 2019 10:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6TLPgKGO4e+YChj0k7INLip6MXL7BlzYN8RpVTNGmwE=; b=gCzu6eHLvtHmo74UR0XtZFFNvw
        lt+v8Xw9aZU0MmjUZRkHT6nR6XBjxZ4HH4EkrPuS09uI2dGSx9ibq/Y0ZNnc7YHABNgQ9+3fTlIfZ
        QTuVHU3lUfSyYZkk22c9kGePnIeLG2pwvQM/H6TsZL30zq28kdCTwYzSinXYn+OkXK1g+tdWHfinH
        NDcioOH2VtEPOdO5qOPbp3h9EZhVyVvlrCGWSDpC8613bx0r8KjpHPkybIrxA7tkSzFekVPB36MMp
        KBlMeNBLDRqK0zVl3KvdrcPc3kA1oS6/O8iHMLtsPxyQUNd4AuHJow82+CIxeNnkUo5VF5B2gKwHX
        jRtkO5PA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49090 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1i4n9J-0003eo-2X; Mon, 02 Sep 2019 10:17:41 -0400
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190901225827.12301-1-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <68ce4c1a-5098-f6b8-e318-1d86d91a3206@lechnology.com>
Date:   Mon, 2 Sep 2019 09:17:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 9/1/19 5:58 PM, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 

...

> David Lechner (6):
>    bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
>    dt-bindings: counter: new bindings for TI eQEP
>    counter: new TI eQEP driver
>    ARM: dts: am33xx: Add nodes for eQEP
>    ARM: dts: am335x-boneblue: Enable eQEP
>    ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi
> 

In case anyone notices, this series only has 5 patches, not 6. "ARM: dts:
am335x-boneblue: Use of am335x-osd335x-common.dtsi" is unrelated and was
submitted separately.

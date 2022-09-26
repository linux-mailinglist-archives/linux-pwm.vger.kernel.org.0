Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB805EAA0A
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiIZPQd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiIZPP7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 11:15:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15E543C1;
        Mon, 26 Sep 2022 07:00:27 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbkqQ3lxgzHqTZ;
        Mon, 26 Sep 2022 21:58:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:00:25 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:00:24 +0800
Subject: Re: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe()
 helper
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <linux-fbdev@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee@kernel.org>
References: <20220926133258.1104850-1-yangyingliang@huawei.com>
 <YzGrLsNrwEyL98nP@maple.lan> <YzGsHadJ+HGJETJv@maple.lan>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <94e1b4a3-c1d9-67b1-062d-945b58b230c3@huawei.com>
Date:   Mon, 26 Sep 2022 22:00:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YzGsHadJ+HGJETJv@maple.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 2022/9/26 21:41, Daniel Thompson wrote:
> On Mon, Sep 26, 2022 at 02:37:50PM +0100, Daniel Thompson wrote:
>> On Mon, Sep 26, 2022 at 09:32:58PM +0800, Yang Yingliang wrote:
>>> In the probe path, dev_err() can be replaced with dev_err_probe()
>>> which will check if error code is -EPROBE_DEFER and prints the
>>> error name. It also sets the defer probe reason which can be
>>> checked later through debugfs. It's more simple in error path.
>> I'd prefer to have received these patches as a patchset rather than
>> individual patches... but it is a good change so:
>>
>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Oops. My last mail neglected to mention that you did not sign off your
> changes (meaning we cannot accept them). When you re-send this please
> add a SoB and combine with the other similar patches.
I missed -s when doing format-patch, I will add my SoB and your reivew 
tag in v2.

Thanks,
Yang
>
>
> Daniel.
> .

Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9452B1128
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKLWPA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 17:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgKLWO7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 17:14:59 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE63C0613D1;
        Thu, 12 Nov 2020 14:14:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so9827525lfh.2;
        Thu, 12 Nov 2020 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6I7BUpsnPeFRDPSie+hImwdRFU/lPQPc9b4Pu6iDC2E=;
        b=rTk36LmZQcm5DdyOg9CK1Elk91TFk0T8lyUlO9RxBsp5ITaOWlFWcg3AV0rTW9G7Fl
         B6TACsnPLGb34KzxDAUE5JNpA8rKCiIYmwnsooKuQ5CJPenNHaDkySPSIz0N4dA2mLC2
         ceGHtL+0omSK/rfvc/iBFGMPW7YFmDKVdtwAqouRvCKmxOe0YX6rh655e/OEj8aNiO7i
         2TnSG5M0WfSwHXJLwfwFsxeQVYZO/NoD6krHxrPimFlpUvEHQ0Flcj2/UVNE7RA8OKWv
         F5nTBOfRpIsNskD3f1jdTo1Fs37JxPEI37HHCcMNOqLF/lrAhV14qvEdFLt3uc4uef0i
         siZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6I7BUpsnPeFRDPSie+hImwdRFU/lPQPc9b4Pu6iDC2E=;
        b=hHAizrxY+VJb5l5W2edCSRf+4HZsiI3pltpE4Dn2oGPDZe23cMH92eN5VbyxSb0Vg8
         kmDPJYayq2yL+JF74vdFWMsD5/J3s0FB9Wx9iu+6Qmz4/rGw6iBNsBKmKZkTnoIYFWGi
         ekq7yhPBnoeQccu23e3nkeSFQu/QZQBtvQn62/mo3NHHsYGEvZG/NMQzz+LjyEeIGKpy
         +8GCPJFWTSo9ZJ8TghjyGMMXUVh6VODtLqilM8ERPBJNnKhwv8I2G9OFivOSNc/kzLmt
         oPYMQgdX4QvHQBsB3j0aOaWixCuErAgNcx5165YHejhUEeILcQHD6W5KBqVwyQ4Gp8Px
         f1HA==
X-Gm-Message-State: AOAM5330jmLucZewCHq+mDg7YVTatJh3HlsrTKyXmIGY3Dh+hJAeKG7Z
        VuFeLsNcgHpy2QIQbLxOWZwoS8EIfBU=
X-Google-Smtp-Source: ABdhPJyBaFcKp4/EPF+acP6+aR+EtI8BnydIDUm/bvPzHQQAYMYoVmfy0wH61huOt4WJ1kuffSiKGA==
X-Received: by 2002:a19:7108:: with SMTP id m8mr661367lfc.246.1605219287612;
        Thu, 12 Nov 2020 14:14:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id z200sm968935lfc.189.2020.11.12.14.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 14:14:46 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
 <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
 <20201112204358.GA1027187@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <25942da9-b527-c0aa-5403-53c9cc34ad93@gmail.com>
Date:   Fri, 13 Nov 2020 01:14:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112204358.GA1027187@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

12.11.2020 23:43, Thierry Reding пишет:
>> The difference in comparison to using voltage regulator directly is
>> minimal, basically the core-supply phandle is replaced is replaced with
>> a power-domain phandle in a device tree.
> These new power-domain handles would have to be added to devices that
> potentially already have a power-domain handle, right? Isn't that going
> to cause issues? I vaguely recall that we already have multiple power
> domains for the XUSB controller and we have to jump through extra hoops
> to make that work.

I modeled the core PD as a parent of the PMC sub-domains, which
presumably is a correct way to represent the domains topology.

https://gist.github.com/digetx/dfd92c7f7e0aa6cef20403c4298088d7

>> The only thing which makes me feel a bit uncomfortable is that there is
>> no real hardware node for the power domain node in a device-tree.
> Could we anchor the new power domain at the PMC for example? That would
> allow us to avoid the "virtual" node.

I had a thought about using PMC for the core domain, but not sure
whether it will be an entirely correct hardware description. Although,
it will be nice to have it this way.

This is what Tegra TRM says about PMC:

"The Power Management Controller (PMC) block interacts with an external
or Power Manager Unit (PMU). The PMC mostly controls the entry and exit
of the system from different sleep modes. It provides power-gating
controllers for SOC and CPU power-islands and also provides scratch
storage to save some of the context during sleep modes (when CPU and/or
SOC power rails are off). Additionally, PMC interacts with the external
Power Manager Unit (PMU)."

The core voltage regulator is a part of the PMU.

Not all core SoC devices are behind PMC, IIUC.

> On the other hand, if we were to
> use a regulator, we'd be adding a node for that, right? So isn't this
> effectively going to be the same node if we use a power domain? Both
> software constructs are using the same voltage regulator, so they should
> be able to be described by the same device tree node, shouldn't they?

I'm not exactly sure what you're meaning by "use a regulator" and "we'd
be adding a node for that", could you please clarify? This v1 approach
uses a core-supply phandle (i.e. regulator is used), it doesn't require
extra nodes.

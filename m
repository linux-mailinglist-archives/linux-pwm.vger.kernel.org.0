Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C992AE821
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 06:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKF2K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 00:28:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:2823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKKF2I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 11 Nov 2020 00:28:08 -0500
IronPort-SDR: M2g1kwnba+jqfNcMliTf4oqVij9N7nDIqAAXiCH++U0EGGP31NPRVEYk8WaybIqgjfzqGozItY
 gKaAHb+VYv6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170205712"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170205712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:28:05 -0800
IronPort-SDR: DtccRcnMWl2HOjP2/ap2pCY09HaV4zHN5WtPAZ87S0yuJPN69epEPk3DO8jppF8Z3F7TstjTM7
 DYjo1Z2h38lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="398907120"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2020 21:28:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 21:28:05 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 21:28:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 21:28:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 21:28:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYaAzV0toIOxLbOkgCUJYNXDrVGGBQ2TNv2R/9VIuPfIbWhxnWxx/YjBO3hTzVmJqhX0oQ49tbiLm6lT5asf5aJCxUbek+FE9RF9YK8DJ/kNyAOHMm/c+sYOYpXoLgdD2o6FNR03OdwNC7re0nFC0TfIKjM2rakXH+24fICI0Je5NcrKiY0lGeA/QDUBjJJCg+WW/Gq+4XDRzgBcQRV933wQ2mXGTyxcbdlSTqmUVmSkGVGHYrwdvvjN51MO7lqZFJhiK9RA/pQ+QvBfKN9WZsY8vndv9aKWi6KPhnNQp1ZEPLO5nWHzLUEqd/JGhyMTFXGAgbA6y1T152mLvlBtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdfjreMHkHkUcrm1ZLUPj2oTmc7/2XUg6RYC5w9VMgc=;
 b=Jj05YtO4vN3QaYDk4UeShZZ40N9v5/vWUAzX0CM29bVIlqA0DtZJTA+O6fBeiOi5KCupqh05hSu1j9GD+3V+5MxHdcD6LTppu1gaj0svTUILFuXjbJJL2LAc+PvMSYlxpgFinnyKG1pMJhA70/8JJUXUNnbko+F/g8XH2YqWwtrqcA6Cljcd0G8Ig3B2qNdEmhVxk/wyRpMGhd/MNEOnPs5809UvQefUwwjlHtkvFMg7FESSOgH7/6wqJoem/VvkpjoccDTa9Wcf4gfiX5jSzdL+dg8gpnFf1qjfliK3wILCXVglFX2SiPBvpzw6yQM9L6SPZ9mO52dhjttrl+n3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdfjreMHkHkUcrm1ZLUPj2oTmc7/2XUg6RYC5w9VMgc=;
 b=xbK9TroblH4t1s5CYMaYYU7FcZkkA+KxWYOcjfWtchlmmtXQz3GdNVIJ2Rnq6Hc51zcb16uGJ+1oDJm4fVcQRtT/Tgfsc/NxgLl+cFsQWFHVJuPQ3fDqZOZuwjoyJmhcVaoGh6tVDhsHeiBnRwYsy2ywrVOCg6uChRLpmFuAxFU=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB4188.namprd11.prod.outlook.com (2603:10b6:5:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 05:28:02 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef%4]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 05:28:02 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v14 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v14 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWqEHRXGxDTJAk202WJg7qNFqk3anCfFyA
Date:   Wed, 11 Nov 2020 05:28:02 +0000
Message-ID: <DM6PR11MB4250BCC182F2E99AA29362EDFBE80@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1603350036.git.vijayakannan.ayyathurai@intel.com>
 <9d567489a6d05da52d515de754fa97da30ba2b85.1603350036.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <9d567489a6d05da52d515de754fa97da30ba2b85.1603350036.git.vijayakannan.ayyathurai@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.177.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca4453f-be5d-4eb8-61a4-08d886028f24
x-ms-traffictypediagnostic: DM6PR11MB4188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4188FF20088675ED17B3E0B1FBE80@DM6PR11MB4188.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5mmDz/YsVoRE8ydPTx8vFKbyae5HLTr2yZKT1HLJySedIfrjm7QgocukeqJ3tPyXWqIQK9wJvfx07/+aIBY0KR37XU3c5OuUUKQVkD6Y+gqao7PfST7J/jkiKsJ+nDQxfI1K6K5DkHBayklcgkAgh+87pMmXNHdG2H+Z+Cdt0WITZUt5uV4CNHcm8qSo+6jdhrpfZC6U2fLsdoPq7nScMItutY59qGeOflhQ+qAl7hbyImkfgFT0zozbIpQ5ixVgIsXSDZPvgO3NLFHhHoGJKjvgRWGmqZwrtcit/eBmabrpNhA3IWQLM/Ros3A/kl/wAdU0PXTte+FkooWRg//uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(26005)(86362001)(2906002)(7696005)(64756008)(66946007)(8676002)(5660300002)(52536014)(66476007)(66556008)(186003)(66446008)(4326008)(9686003)(53546011)(76116006)(8936002)(55016002)(478600001)(316002)(110136005)(33656002)(71200400001)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Y8ADYJATadJ1S8Elu1UJPnOkO70F8doMJM7h6hk8xeKGI2szhU2ymbpznVs13yWRlErdUIQie79gQsZrzynX94cFLQE1x35XDByx2ywzXfD46RsSTDe+Vzq8yxW78LZDHBjTnGsupasKy0gsefCyo/701ryxp3umYXNwdGqSw9kuIbKkR7iJ9UVgH4uwJs6Cn8M5J6brqOd8338SNdc5CdBiUcKsHLprq/6qUGioWyqNOriirb1ddP+oF7fiIw2gbYsUnpUJbYfN4zvfldCs8FMiHAyZsCrtQYep6iimy7FZAHb2EBE9J9mTsgAn26CFnO/sA1JCgYsfZxxRd78lDER1Lb0LXugtm+6OoNPNs/ee7DTGpRRaOkGms20+1iPLKDIFKdZhyJihB0a3szQn87SHZBaG9Yj20ca4v/kNoYuBixBEErxq2JHYeO8n+92P2Am5Xl99TusQHUwrllBXYkh0EeikjxNIof5Av/KkK6aseBsERJPomXhTZo9f8vE25c2HtGQZUTtZfjtLoxxrm8T1tMcBad5N++fE7qwsdK92IZdTmkRh5baR7tYo3R+yR4Hq+aWxuqOPo7OGyAEHuyt3u733Ved6ZzLENFDrsGIDIcw6SSky8U7uUlOu/64dhawPP5VdUXpwi1R67ZQW0cqtHdH7p2yO07l8qp39/7dNmE5VzHZzaVrT41AuBM73QqSjzL2X4ZKqsZNjqDQXbXsQXEPwhXOSlmm5mcRqQWXgnfG2dtHM1wCFuIql2h+t28ANsXKfMl6/1eWV3e8mUzl8WwMcZwOOTq1s4nIWVtdWGg98M+UpOWAcRLTQrVnDLSx+vNmFxwMXpTxjkAeVJd3U5jdUXCvxKTgcHd+VPXMarJaNPVYpPYilMg56OV7YUws3yXi7VCTs9D7MR0ZqxA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4453f-be5d-4eb8-61a4-08d886028f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 05:28:02.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03OP87xTtqXPI5uledSmiHFlwstG6Uu4rNjHx5hjSqvEybfq9w+r44T4NzBNBKUDY+lJlnIpYnFwh3kipAiuCLTxZpm535R9YSJQ3yW2CijygrkWyh8X8N7W60HebYp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4188
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQoNCj4gRnJvbTogQXl5YXRodXJhaSwgVmlqYXlha2FubmFuIDx2aWpheWFrYW5uYW4uYXl5
YXRodXJhaUBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAyMiBPY3RvYmVyLCAyMDIwIDM6
MTUgUE0NCj4gVG86IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsgdS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlOw0KPiByb2JoK2R0QGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXB3bUB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBXYW4gTW9oYW1hZCwNCj4g
V2FuIEFobWFkIFphaW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+
Ow0KPiBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IG1ncm9zc0BsaW51eC5pbnRl
bC5jb207IFJhamENCj4gU3VicmFtYW5pYW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWph
LnN1YnJhbWFuaWFuQGludGVsLmNvbT47DQo+IEF5eWF0aHVyYWksIFZpamF5YWthbm5hbiA8dmlq
YXlha2FubmFuLmF5eWF0aHVyYWlAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjE0IDEv
Ml0gcHdtOiBBZGQgUFdNIGRyaXZlciBmb3IgSW50ZWwgS2VlbSBCYXkNCj4gDQo+IEZyb206IFZp
amF5YWthbm5hbiBBeXlhdGh1cmFpIDx2aWpheWFrYW5uYW4uYXl5YXRodXJhaUBpbnRlbC5jb20+
DQo+IA0KPiBUaGUgSW50ZWwgS2VlbSBCYXkgU29DIHJlcXVpcmVzIFBXTSBzdXBwb3J0Lg0KPiBB
ZGQgdGhlIHB3bS1rZWVtYmF5IGRyaXZlciB0byBlbmFibGUgdGhpcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IExhaSwgUG9leSBTZW5nIDxwb2V5LnNlbmcubGFpQGludGVsLmNvbT4NCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBWaW5lZXRoYSBHLiBKYXlhIEt1bWFyYW4NCj4gPHZpbmVldGhhLmcuamF5YS5r
dW1hcmFuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmluZWV0aGEgRy4gSmF5YSBLdW1h
cmFuDQo+IDx2aW5lZXRoYS5nLmpheWEua3VtYXJhbkBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5
OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4g
Q28tZGV2ZWxvcGVkLWJ5OiBWaWpheWFrYW5uYW4gQXl5YXRodXJhaQ0KPiA8dmlqYXlha2FubmFu
LmF5eWF0aHVyYWlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaWpheWFrYW5uYW4gQXl5
YXRodXJhaQ0KPiA8dmlqYXlha2FubmFuLmF5eWF0aHVyYWlAaW50ZWwuY29tPg0KPiBSZXZpZXdl
ZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4N
Cj4gLS0tDQoNClBsZWFzZSBjb25zaWRlciByZXZpZXcgdGhpcyBwYXRjaCBhbmQgbGV0IG1lIGtu
b3cgaWYgdGhlcmUgaXMgYW55IGZ1cnRoZXIgZmVlZGJhY2suDQoNCkkgaGF2ZSBhbHNvIGNvbXBp
bGVkIGFuZCB0ZXN0ZWQgdGhpcyBwYXRjaCB3aXRoDQoJdGFnOiB2NS4xMC1yYzIJKDNjZWExMWNk
NWUzYjAwZDkxY2FmMGI0NzMwMTk0MDM5YjQ1YzU4OTEpDQoNClRoYW5rcyBpbiBhZHZhbmNlLA0K
VmlqYXkNCg==
